class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy, :add_subjects, :subject_add, :publish_result_for_students]

  # GET /grades
  # GET /grades.json


  def publish_result_for_students
    @students = @grade.students
  end

  def publish_result_for_selected_students
    student_ids = params[:ids].split(',')
    puts student_ids
    grade = Student.find(student_ids.first).grade
    all_students = grade.students
    Notification.create(user_id: current_user.id, activity: "Published Result for #{student_ids.count} students of #{grade.full_name}")
    all_students.where.not(id: student_ids).each do |std|
      std.publish_result = false
      std.save
    end
    all_students.where(id: student_ids).each do |std|
      std.publish_result = true
      std.save
    end
    publish_result = PublishResult.find_or_create_by(class_id: grade.id, batch_id: grade.batch.id)
    publish_result.publish = true
    if publish_result.save
      get_report_card_urls(grade, grade.batch)
      msg = 'Results Published Successfully.'
    end

  end

  def add_subjects
    # @subjects = Subject.where(parent: nil).order(:name)
    @subjects = Subject.order('name')
  end

  def promote
    # return render json: session[:confirm_password]
    @identifier = params[:identifier]
    if session[:confirm_password] == true
      @grades = Grade.where("section is not null").order(:name)
      @main_grades = []
      session[:confirm_password] = false
    else
      redirect_to root_path, alert: "Warning! Permissio Restricted...!!!"
    end
  end

  def promoter
    @grade = Grade.find(params[:grade_id])
    @promote_to = params[:promote_to]
    @students = @grade.students
  end

  def get_classes
    puts "+=+=+"*100
    grade = Grade.find(params[:grade_id])
    identifier = params[:identifier]
    if grade.name.downcase =~ /kg/i 
      grades = Grade.where("section is not null and name != ?", grade.name).order(:name)
    else
      if identifier == 'promote'
        grades = Grade.where.not("name = 'KG' or name = 'KG1' or name = 'KG2' or name = 'KG3'")
        grades = grades.where("section is not null and CAST(coalesce(name, '0') AS integer) > ?",grade.name.to_i).order(:name)
      else
        # grades = Grade.where.not("name ILIKE 'KG' or")
        if grade.name.downcase == '1'
          grades = Grade.where("name = 'KG' or name = 'KG1' or name = 'KG2' or name = 'KG3'")
          grades = grades.where("section IS NOT NULL")
        else
          grades = Grade.where.not("name = 'KG' or name = 'KG1' or name = 'KG2' or name = 'KG3'")
          grades = grades.where("section is not null and CAST(coalesce(name, '0') AS integer) < ?", grade.name.to_i).order(:name)
        end
      end
    end

    respond_to do |format|
      format.json {render json: {grades: grades}}
    end
  end

  def promote_students
    student_ids = params[:students]
    promote_to = params[:promote_to]
    student_ids.try(:each) do |std_id|
      std = Student.find(std_id)
      std.grade_id = promote_to
      std.save!
    end
    redirect_to root_path, notice: "Grades has been updated Successfully..!"
    # return render json: params
  end

  def subject_add
    # return render json: params
    # @grade.associations.destroy_all if @grade.associations.present?
    subjects = params[:flags].keys
    subjects.try(:each) do |subject|
      if params[:flags][subject][:check]
        a = @grade.associations.find_or_create_by(subject_id: subject)
        a.lectures = params[:flags][subject][:lectures]
        a.save
      else
        sub_name = Subject.find(subject)
        a = @grade.associations.find_by(subject_id: subject)
        settings = ReportCardSetting.where(grade_id: @grade.id, batch_id: Batch.last.id)
        
        settings.try(:each) do |setting|
          setting.subjects.find_by_name(sub_name.name).destroy if setting.subjects.find_by_name(sub_name.name).present? 
        end
        Grade.where('name=? AND section IS NOT NULL AND batch_id = ?', @grade.name, Batch.last.id).try(:each) do |grade|
          grade.bridges.find_by(subject_id: subject).delete if grade.bridges.find_by(subject_id: subject)
        end
        a.delete if a.present?
      end
    end
    Notification.create(user_id: current_user.id, activity: "Updated Subjects to (#{Subject.where(id: @grade.associations.pluck(:subject_id)).pluck(:name).join(',')}) for Grade #{@grade.full_name}")
    @classes = Grade.where("name = '#{@grade.name}' AND section IS NOT NULL")
    if @classes.present?
      redirect_to grades_path({grade_name: @grade.name}), notice: "Subjects has been added successfully...!!!"
    else
      redirect_to new_grade_path, notice: "Subjects has been added successfully...!!!"
    end
  end

  def add_students
    @grade = Grade.find(params[:id])
    if @grade.campus = 'Boys'
      @students = @grade.parent.students.where(gender: 'MALE') rescue []
    else
      @students = @grade.parent.students.where(gender: 'FEMALE') rescue []
    end


  end

  def student_add
    if params[:flags]
      student_ids = params[:flags].keys
      student_ids.try(:each) do |std_id|
        s = Student.find(std_id)
        s.grade_id = params[:grade_id]
        s.save!
      end
    end
    Notification.create(user_id: current_user.id, activity: "Added students to #{Grade.find(params[:grade_id]).full_name}")
    redirect_to all_student_grades_path({grade_id: params[:grade_id]}), notice: "Students added to the Class successfully"
  end

  def index
    if current_user.role.rights.where(value: "view_grade").blank?
      redirect_to root_path, alert: "Sorry! You are not authorized"
    else
      respond_to do |format|
        format.html{
          name = params[:grade_name]
          @grades = Grade.where("section IS NOT NULL and name = ?", name) if name.present?
        }
        format.pdf {
          @grades = Grade.where('section IS NOT NULL').order('name')
          @title = 'All Classes List'
          render pdf: 'classes.pdf', template: 'grades/index.pdf.erb',  layout: 'pdf.html.erb',
                 margin: { top: 30, bottom: 11, left: 5, right: 5},
                 header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
                 footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
        }
      end
    end
  end

  def all_grades
    @grades = Grade.where(section: nil).order(:name)
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf {
        @bridges = @grade.bridges
        @title = "Grade: #{@grade.full_name} - Subject Assignments"
        render pdf: 'subjects_assignments.pdf', template: 'grades/show.pdf.erb',  layout: 'pdf.html.erb',
               margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
      }
    end
  end

  # GET /grades/new
  def new
    # return render json: params
    if current_user.role.rights.where(value: "create_grade").nil?
      redirect_to root_path, alert: "Sorry! You are not authorized"
    else
      if params[:maingrade]
        @maingrade = true
      end
      @grade = Grade.new
      @batch = Batch.all.pluck(:name, :id)
      @batches=Batch.all
    end

  end

  # GET /grades/1/edit
  def edit
    if current_user.role.rights.where(value: "update_subject").nil?
      redirect_to root_path, alert: "Sorry! You are not authorized"
    end
    if params[:maingrade]
      @maingrade = true
    else
      @employees = Employee.where('employee.category.name' => "Academic")
      @batches = Batch.all
    end
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)
    if @grade.save
      Notification.create(user_id: current_user.id, activity: "Created New grade #{@grade.full_name} in Batch #{@grade.batch.try(:name)}")
      if params[:maingrade]
        redirect_to add_subjects_grade_path(@grade.id), notice: "Class Added Successfully"
      else
        redirect_to new_bridge_path(class_id: @grade.id), notice: "Class Added Successfully"
      end
    else
      @batch = Batch.all.pluck(:name, :id)
      @batches=Batch.all
      @maingrade = params[:maingrade]
      render :new
    end
  end

  def all_student
    if params[:grade_id]
      @grade = Grade.find(params[:grade_id])
    else
      @bridge = Bridge.find(params[:bridge_id])
      @grade = @bridge.grade
    end
    @students = @grade.students
    @student = @students.first
    respond_to do |format|
      format.html
      format.pdf{
        @title = 'All Students List'
        render pdf: 'students.pdf', template: 'students/index.pdf.erb',  layout: 'pdf.html.erb',
               margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
      }
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    if @grade.update(grade_params)
      if params[:maingrade]
        redirect_to add_subjects_grade_path(@grade.id), notice: 'Grade Updated Successfully'
      else
        redirect_to new_bridge_path(class_id: @grade.id), notice: 'Class Updated Successfully'
      end
    else
      @maingrade = params[:maingrade]
      @batch = Batch.all.pluck(:name, :id)
      @batches=Batch.all
      render :edit
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.students.try(:each) do |std|
      std.grade_id = nil
    end
    @grade.bridges.delete_all
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url(grade_name: @grade.name), notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def get_report_card_urls(klass, batch)
      students = klass.students
      if students.present?
        students.each do |std|
          report_card = ReportCard.find_by(student_id: std.id, grade_id: klass.id, batch_id: batch.id)
          if report_card.present?
            report_card.update_attributes(
                quarter_result_url: result_card_url(std.id, klass.id, batch.id),
                final_result_url: complete_result_card_url(std.id, klass.id, batch.id)
            )
          end
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find_by_id(params[:id])
      if @grade.present?
        return @grade
      else
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name, :section, :batch_id, :campus, :max_no_of_students, :grade_group_id)
    end
end
