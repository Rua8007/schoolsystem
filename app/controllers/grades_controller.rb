class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy, :add_subjects, :subject_add]

  # GET /grades
  # GET /grades.json

  def add_subjects
    # @subjects = Subject.where(parent: nil).order(:name)
    @subjects = Subject.order('name')
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
        a = @grade.associations.find_by(subject_id: subject)
        a.delete if a.present?
      end
    end
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
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name, :section, :batch_id, :campus, :max_no_of_students, :grade_group_id)
    end
end
