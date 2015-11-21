class MarksController < ApplicationController
  before_action :set_mark, only: [:show, :edit, :update, :destroy]

  # GET /marks
  # GET /marks.json
  def index
    @bridges = []
    @grades = Grade.where(section: nil).order('name')
    if current_user.role.rights.where(value: 'enter_all_marks').nil?
      @grades.each do |grade|
        @subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
        @subgrades.each do |sub_grade|
          bridge = Bridge.where(grade_id: sub_grade.id, employee_id: current_user.id).try(:first)
          @bridges << bridge if bridge.present?
        end
      end
    else
      @grades.each do |grade|
        @subgrades = Grade.where('name=? AND section IS NOT NULL', grade.name).order('section')
        @subgrades.each do |sub_grade|
          bridge = Bridge.where(grade_id: sub_grade.id, employee_id: Employee.find_by_email(current_user.email).id ).try(:first)
          @bridges << bridge if bridge.present?
        end
      end
    end

    @classes = []
    @bridges.each do |bridge|
      @classes << bridge.grade
    end
  end

  # GET /marks/1
  # GET /marks/1.json
  def show
  end

  # GET /marks/new
  def new
    @mark = Mark.new
  end

  # GET /marks/1/edit
  def edit
  end

  # POST /marks
  # POST /marks.json
  def create
    @mark = Mark.new(mark_params)

    respond_to do |format|
      if @mark.save
        format.html { redirect_to marks_path, notice: 'Mark was successfully created.' }
        format.json { render :show, status: :created, location: @mark }
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marks/1
  # PATCH/PUT /marks/1.json
  def update
    respond_to do |format|
      if @mark.update(mark_params)
        format.html { redirect_to marks_path, notice: 'Mark was successfully updated.' }
        format.json { render :show, status: :ok, location: @mark }
      else
        format.html { render :edit }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marks/1
  # DELETE /marks/1.json
  def destroy
    @mark.destroy
    respond_to do |format|
      format.html { redirect_to marks_url, notice: 'Mark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_student
    @grade = Grade.find params[:grade_id]
    @employee = current_user
    @students = @grade.students
  end

  def select_marks_details
    @student = Student.find(params[:student_id])
    @report_card = ReportCard.find_or_create_by(student_id: @student.id, grade_id: @student.grade.id)
    @exams = Exam.where(batch_id: @student.grade.batch_id)
    @marks_divisions = @student.grade.parent.grade_group.marks_divisions if @student.grade.parent.present?
        @bridges = Bridge.where(grade_id: params[:grade_id], employee_id: params[:employee_id])
    @subjects = []
    @all_subjects = Subject.where(parent: nil).order('name')
    @all_subjects.each do |subject|
      @bridges.each do |bridge|
        @subjects << subject if subject.id == bridge.subject_id
      end
    end
    if @subjects.present? and @exams.present? and @marks_divisions.present? and @report_card.present?
      @mark = Mark.find_or_initialize_by(exam_id: @exams.first.id, subject_id: @subjects.first.id, division_id: @marks_divisions.first.id, report_card_id: @report_card.id)
      if @mark.new_record?
        @mark.total_marks = @marks_divisions.first.total_marks
        @mark.passing_marks = @marks_divisions.first.passing_marks
        @mark.save
      end
      @marks_division = MarksDivision.find(@mark.division_id)
      if @marks_division.sub_divisions.present?
        @marks_division.sub_divisions.each do |sub_division|
          @sessional = Sessional.find_or_initialize_by(name: sub_division.name, mark_id: @mark.id, sub_division_id: sub_division.id)
          if @sessional.new_record?
            @sessional.total_marks = sub_division.total_marks
            @sessional.save
            @mark.sessionals << @sessional
          end
        end
      end
    else
      flash[:notice] = 'Some Configurations Are Missing.'
    end
  end

  def enter_marks
    @mark = Mark.find_or_initialize_by(mark_params)
    @marks_division = MarksDivision.find(@mark.division_id)
    if @mark.new_record?
      @mark.total_marks = @marks_division.total_marks
      @mark.passing_marks = @marks_division.passing_marks
      @mark.save
    end
    if @marks_division.sub_divisions.present?
      @marks_division.sub_divisions.each do |sub_division|
        @sessional = Sessional.find_or_initialize_by(name: sub_division.name, mark_id: @mark.id, sub_division_id: sub_division.id)
        if @sessional.new_record?
          @sessional.total_marks = sub_division.total_marks
          @sessional.save
          @mark.sessionals << @sessional
        end
      end
    end
  end

  def save_marks
    @mark = Mark.find(params[:id])
    @marks_division = MarksDivision.find(@mark.division_id)
    if @mark.update(mark_params)
      @notice = 'Uploaded Marks Successfully.'
    else
      @notice = "Sorry Couldn't Upload Marks."
    end

    if @mark.sessionals.present?
      @mark.obtained_marks = @mark.sessionals.sum(:obtained_marks)
      @mark.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mark
      @mark = Mark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mark_params
      params.require(:mark).permit(:exam_id, :division_id, :subject_id, :report_card_id, :total_marks, :passing_marks, :obtained_marks,
                                   sessionals_attributes: [:id, :name, :obtained_marks])
    end
end
