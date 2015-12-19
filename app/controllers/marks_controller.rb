class MarksController < ApplicationController
  include MarksHelper
  before_action :set_mark, only: [:show, :edit, :update, :destroy]

  # GET /marks
  # GET /marks.json
  def index
    @grades = Grade.where(section: nil).order('name')
    @bridges = get_employee_bridges(current_user)
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

  def select_subject_and_exam
    @class = Grade.find( params[:grade_id] )
    @main_grade = @class.parent if @class.present?

    @bridges = get_grade_bridges(current_user, @class.id) rescue []
    @subjects = []
    @bridges.each do |bridge|
      @subjects << bridge.subject
    end
    @subjects = @subjects.sort_by { |k| k.name }
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @class.batch_id).order('name')
  end

  def enter_marks
    @class = Grade.find(params[:grade_id])
    @exam = Exam.find(params[:exam_id])
    @subject = Subject.find(params[:subject_id])
    @main_grade = @class.parent if @class.present?
    if @class.students.present?
      @students = @class.students.sort_by { |k| k.fullname }
    end

    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @class.batch_id, exam_id: @exam.id) if @main_grade.present?

    @marks_divisions = @setting.marks_divisions.order('name')
    @marks_division = @marks_divisions.first
    @marks_division = ReportCardDivision.find(params[:division_id]) if params[:division_id].present?

    @students.try(:each) do |std|
      ReportCard.find_or_create_by(student_id: std.id, grade_id: @class.id, batch_id: @class.batch_id)
    end

    check_subjects(@setting, [@subject])
  end

  def save_marks
    @class = Grade.find(params[:class_id]) if params[:class_id].present?
    @exam = Exam.find(params[:exam_id]) if params[:exam_id].present?
    @subject = Subject.find(params[:subject_id]) if params[:subject_id].present?
    @marks_division = ReportCardDivision.find(params[:division_id]) if params[:division_id].present?

    @main_grade = @class.parent if @class.present?
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @class.batch_id, exam_id: @exam.id) if @main_grade.present?
    # @report_card_exam = ReportCardExam.find_by_exam(@exam) if @exam.present?
    @report_card_subject = @setting.subjects.find_by(name: @subject.name, code: @subject.code) if @subject.present?
    #@report_card_division = ReportCardDivision.find_by_marks_division(@marks_division) if params[:division_id].present?

    @students = params[:sessionals]
    @dates = params[:sessionals_date]
    @students.each do |std|
      student = Student.find(std.first.to_i) rescue nil
      std_marks = std.last
      std_marks.each_with_index do |marks, index|
        if student.present?
          @report_card = ReportCard.find_by student_id: student.id, grade_id: @class.id, batch_id: @class.batch_id
          @mark = Mark.find_or_create_by(report_card_id: @report_card.id, exam_id: @exam.id, subject_id: @report_card_subject.id, division_id: @marks_division.id)
          @sessional = Sessional.find_or_create_by name: "#{@marks_division.name} #{index + 1}", mark_id: @mark.id
          @sessional.update( obtained_marks: marks.to_f, mark_date: @dates[index])
          @mark.update(obtained_marks: @mark.sessionals.average(:obtained_marks), passing_marks: @marks_division.passing_marks, total_marks: @marks_division.total_marks)
        else
          flash[:notice] = 'Sorry, Something Bad Happened.'
          break
        end
      end
    end

    redirect_to enter_division_marks_path( @class.id, @subject.id, @exam.id, @marks_division.id)
  end

  def subject_result
    @bridges = get_all_employee_bridges(current_user)
    @classes = []
    @subjects = []
    @bridges.each do |bridge|
      @classes << bridge.grade unless @classes.include? bridge.grade
    end
    @class = params[:class_id].present? ? Grade.find_by(id: params[:class_id]) : @classes.first
    @main_grade = @class.parent if @class.present?
    @exams = @main_grade.exams.where(batch_id: @class.batch_id)
    @exam = @exams.first


    @class_bridges = @bridges.map{ |k| k if k.grade_id == @class.id }.compact
    #To See Child Subjects Result
    @class_bridges.each do |bridge|
      @subjects << bridge.subject
    end
    # #To See Child and Parents Both
    # @class_bridges.each do |bridge|
    #   if bridge.subject.parent_id.present?
    #     @subjects << bridge.subject.parent unless @subjects.include?(bridge.subject.parent)
    #   end
    #   @subjects << bridge.subject unless @subjects.include?(bridge.subject)
    # end

    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @class.batch_id, exam_id: @exam.id)
    @report_card_subjects = []
    @subjects.each do |sub|
      @report_card_subjects << @setting.subjects.find_by(name: sub.name, code: sub.code)
    end
    @report_card_subjects = @report_card_subjects.compact
  end

  def get_subject_result
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @exam = Exam.find_by_id(params[:exam_id])
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @class.batch_id, exam_id: @exam.id)
    @subject = ReportCardSubject.find_by_id(params[:subject_id])
  end

  def class_result
    @bridges = get_all_employee_bridges(current_user)
    @classes = []
    @subjects = []
    @bridges.each do |bridge|
      @classes << bridge.grade unless @classes.include? bridge.grade
    end
    @class = params[:class_id].present? ? Grade.find_by(id: params[:class_id]) : @classes.first
    @main_grade = @class.parent if @class.present?
    @class_bridges = @bridges.map{ |k| k if k.grade_id == @class.id }.compact
    #To See Child Subjects Result
    @class_bridges.each do |bridge|
      @subjects << bridge.subject
    end
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @class.batch_id)
    @exam = params[:exam_id].present? ? Exam.find(params[:exam_id]) : @exams.first
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @class.batch_id, exam_id: @exam.id)
    check_subjects(@setting, @subjects) if @setting.present?
  end

  def get_grade_exams
    klass = Grade.find(params[:class_id])
    grade = klass.parent if klass.present?
    exams = Exam.where(grade_id: grade.id, batch_id: klass.batch_id).order('name') if klass.present? and grade.present?

    render json: {exams: exams}
  end

  def result_card
    @student = Student.find(params[:student_id])
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @batch = Batch.find(params[:batch_id])

    @report_card = ReportCard.find_by(student_id: @student.id, grade_id: @class.id, batch_id: @batch.id)
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @batch.id).order('name') || []
    @settings = ReportCardSetting.where(grade_id: @main_grade.id, batch_id: @batch.id)

    respond_to do |format|
      format.html{}
      format.pdf {
        @exam = Exam.find(params[:exam_id])
        render pdf: "#{@student.fullname}-#{@exam.name}-#{@batch.name}", template: 'marks/quarter_result.pdf.erb',  layout: 'pdf.html.erb', orientation: 'Landscape', margin: { top: 5, bottom: 11, left: 0, right: 0}, footer: { center: 'Page: [page] of [topage]'}
      }
    end
  end

  def complete_result_card
    @student = Student.find(params[:student_id])
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @batch = Batch.find(params[:batch_id])

    @report_card = ReportCard.find_by(student_id: @student.id, grade_id: @class.id, batch_id: @batch.id)
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @batch.id).order('name') || []
    @settings = ReportCardSetting.where(grade_id: @main_grade.id, batch_id: @batch.id)
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
