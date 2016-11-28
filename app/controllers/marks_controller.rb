require 'csv'
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
    # return render json: Sessional.find
    sessional = Sessional.find(params[:sessional_id])
    @exam = Exam.find(params[:exam_id])
    @grade = Grade.find(params[:grade_id])
    @marks_division = ReportCardDivision.find(params[:marks_division_id])
    report_card_subject_id = params[:report_card_subject_id]
    @grade.students.try(:each) do |std|
      @student_report_card = ReportCard.find_by( grade_id: @grade.id, batch_id: Batch.last.id, student_id: std.id)
      if @student_report_card.present?
        @student_mark = Mark.find_by(report_card_id: @student_report_card.id, exam_id: @exam.id, subject_id: report_card_subject_id, division_id: @marks_division.id)
        @student_mark.sessionals.find_by(name: sessional.name).delete
        @student_mark.obtained_marks = @student_mark.sessionals.average(:obtained_marks).to_f.round(2)
        @student_mark.save!
      end
    end
    sessional.delete
    redirect_to marks_path, alert: "Record Has Been Deleted...!!!"
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
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: Batch.last.id).order('name')
  end

  def enter_marks
    @max_allowed = Performance.max_allowed
    @class = Grade.find(params[:grade_id])
    @exam = Exam.find(params[:exam_id])
    @subject = Subject.find(params[:subject_id])
    @main_grade = @class.parent if @class.present?
    @setting    = ReportCardSetting.find_by(grade_id: @main_grade.id,
                  batch_id: Batch.last.id, exam_id: @exam.id) if @main_grade.present?
    @report_card_subject = @setting.subjects.find_by(name: @subject.name, code: @subject.code)
    if @class.students.present?
      @students = @class.students.includes(:performances).sort_by { |k| k.fullname }
    end

    @bridge = Bridge.find_by(grade_id: @class.id, subject_id: @subject.id)

    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: Batch.last.id, exam_id: @exam.id) if @main_grade.present?

    @marks_divisions = @setting.marks_divisions
    # @marks_divisions.push(@setting.marks_divisions.find_by_name("Exam Comments"))
    # return render json: @marks_divisions
    @marks_division = @marks_divisions.first
    @marks_division = ReportCardDivision.find(params[:division_id]) if params[:division_id].present?

    @students.try(:each) do |std|
      ReportCard.find_or_create_by(student_id: std.id, grade_id: @class.id, batch_id: Batch.last.id)
    end
    check_subjects(@setting, [@subject])
  end

  def save_marks
    puts "-----------------------"
    puts "-----------------------"
    puts params.inspect
    puts "-----------------------"
    puts "-----------------------"

    @class = Grade.find(params[:class_id]) if params[:class_id].present?
    @exam = Exam.find(params[:exam_id]) if params[:exam_id].present?
    @subject = Subject.find(params[:subject_id]) if params[:subject_id].present?
    @marks_division = ReportCardDivision.find(params[:division_id]) if params[:division_id].present?

    @main_grade = @class.parent if @class.present?
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: Batch.last.id, exam_id: @exam.id) if @main_grade.present?
    # @report_card_exam = ReportCardExam.find_by_exam(@exam) if @exam.present?
    @report_card_subject = @setting.subjects.find_by(name: @subject.name, code: @subject.code) if @subject.present?
    parent_subject = nil
    if @report_card_subject.parent_id != nil
      parent_subject = @report_card_subject.parent
    end
    #@report_card_division = ReportCardDivision.find_by_marks_division(@marks_division) if params[:division_id].present?

    @students = params[:sessionals]
    @dates = params[:sessionals_date]
    @students.each do |std|
      student = Student.find(std.first.to_i) rescue nil
      std_marks = std.last
      std_marks.each_with_index do |marks, index|
        if student.present?
          @report_card = ReportCard.find_by student_id: student.id, grade_id: @class.id, batch_id: Batch.last.id
          @mark = Mark.find_or_create_by(report_card_id: @report_card.id, exam_id: @exam.id, subject_id: @report_card_subject.id, division_id: @marks_division.id)
          if @marks_division.name != "Exam Comments"
            @sessional = Sessional.find_or_create_by name: "#{@marks_division.name} #{index + 1}", mark_id: @mark.id
            @sessional.update( obtained_marks: marks.to_f, mark_date: @dates[index])
            @mark.update(obtained_marks: @mark.sessionals.average(:obtained_marks), passing_marks: @marks_division.passing_marks, total_marks: @marks_division.total_marks)
            if parent_subject != nil && @marks_division.is_divisible == false
              parent_subject.sub_subjects.where.not(id: @report_card_subject.id).try(:each) do |subj|
                if subj.take_exam == false
                  mark = Mark.find_or_create_by(report_card_id: @report_card.id, exam_id: @exam.id, subject_id: subj.id, division_id: @marks_division.id)
                  sessional = Sessional.find_or_create_by name: "#{@marks_division.name} #{index + 1}", mark_id: mark.id
                  sessional.update( obtained_marks: marks.to_f, mark_date: @dates[index])
                  mark.update(obtained_marks: @mark.sessionals.average(:obtained_marks), passing_marks: @marks_division.passing_marks, total_marks: @marks_division.total_marks)
                end
              end
            end
          else
            @sessional = Sessional.find_or_create_by name: "#{@marks_division.name} #{index + 1}", mark_id: @mark.id
            @sessional.update( comments: marks, mark_date: @dates[index])
          end
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
    @exams = @main_grade.exams.where(batch_id: Batch.last.id)
    @exam = Exam.find(params[:exam_id]) if params[:exam_id].present?
    @exam = @exams.first if @exam.nil?


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

    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: Batch.last.id, exam_id: @exam.id)
    @report_card_subjects = []
    @subjects.each do |sub|
      @report_card_subjects << @setting.subjects.find_by(name: sub.name, code: sub.code)
    end
    @report_card_subjects = @report_card_subjects.compact.sort!{ |x,y| x.name <=> y.name }
  end

  def get_subject_result
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @exam = Exam.find_by_id(params[:exam_id])
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: Batch.last.id, exam_id: @exam.id)
    @subject = ReportCardSubject.find_by_id(params[:subject_id])
    @teacher = @class.bridges.where(subject_id: Subject.find_by_name(@subject.name)).last.employee
    respond_to do |format|
      format.js
      format.pdf{
        render pdf: "#{@subject.name}_#{@exam.name}_#{@teacher.full_name}", template: 'marks/get_subject_result.pdf.erb',
               layout: 'pdf.html.erb', margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
      }
    end
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
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: Batch.last.id)
    @exam = params[:exam_id].present? ? Exam.find(params[:exam_id]) : @exams.first
    @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: Batch.last.id, exam_id: @exam.id)
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
        render pdf: "#{@student.fullname}-#{@exam.name}-#{@batch.name}", template: 'marks/quarter_result.pdf.erb',
               layout: 'pdf.html.erb', orientation: 'Landscape', margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_landscape_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_landscape_footer.html.erb'} }
      }
    end
  end

  def complete_result_card
    @fors = 'pdf'
    @student = Student.find(params[:student_id])
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @batch = Batch.last

    @report_card = ReportCard.find_by(student_id: @student.id, grade_id: @class.id, batch_id: @batch.id)
    @exams = Exam.where(grade_id: @main_grade.id, batch_id: @batch.id).order('name') || []
    @settings = ReportCardSetting.where(grade_id: @main_grade.id, batch_id: @batch.id)

    respond_to do |format|
      format.html{}
      format.pdf {
        render pdf: "#{@student.fullname}-#{@batch.name}", template: 'marks/complete_result_card.pdf.erb',
               layout: 'pdf.html.erb', orientation: 'portrait', margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
      }
    end
  end

  def my_results
    @student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last) if current_user.role.name == 'Parent'
    @student = Student.find_by_email(current_user.email) if current_user.role.name == 'Student'
    @class = @student.grade
    if @class.present?
      @batch = @class.batch
      @main_grade = @class.parent
      @report_card = ReportCard.find_by(grade_id: @class.id, student_id: @student.id, batch_id: @batch.id)

      @exams = Exam.where(batch_id: @batch.id, grade_id: @main_grade.id).order('name')
      @exam = params[:exam_id].present? ? Exam.find(params[:exam_id]) : @exams.first

      @setting = ReportCardSetting.find_by(grade_id: @main_grade.id, batch_id: @batch.id, exam_id: @exam.id)
      @subjects = @setting.subjects.where(parent_id: nil).order('name')
      @subject = params[:subject_id].present? ? ReportCardSubject.find(params[:subject_id]) : @subjects.first
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def print_all_students_results
    @class      = Grade.find(params[:class_id]) if params[:class_id].present?
    @exam       = Exam.find(params[:exam_id]) if params[:exam_id].present?
    @batch      = Batch.find(params[:batch_id]) if params[:batch_id].present?
    @main_grade = @class.parent if @class.present?
    @exams      = Exam.where(grade_id: @main_grade.id, batch_id: @batch.id).order('name') || []
    @settings   = ReportCardSetting.where(grade_id: @main_grade.id, batch_id: @batch.id)

    render pdf: "#{@class.full_name}-#{@batch.name}", template: 'marks/print_all_students_results.pdf.erb',
           layout: 'pdf.html.erb', orientation: 'Landscape', margin: { top: 30, bottom: 11, left: 5, right: 5},
           header: { html: { template: 'shared/pdf_landscape_header.html.erb'} }, show_as_html: false,
           footer: { html: { template: 'shared/pdf_landscape_footer.html.erb'} }

  end

  def upload_csv
    @class      = Grade.find(params[:class_id])     if params[:class_id].present?
    @exam       = Exam.find(params[:exam_id])       if params[:exam_id].present?
    @subject    = Subject.find(params[:subject_id]) if params[:subject_id].present?

  end

  def process_csv

    @class      = Grade.find(params[:class_id])     if params[:class_id].present?
    @main_grade = @class.parent if @class.present?
    @exam       = Exam.find(params[:exam_id])       if params[:exam_id].present?
    @subject    = Subject.find(params[:subject_id]) if params[:subject_id].present?
    @setting    = ReportCardSetting.find_by(grade_id: @main_grade.id,
                  batch_id: Batch.last.id, exam_id: @exam.id) if @main_grade.present?

    text = File.read(params[:csv].tempfile) if params[:csv].present?
    begin
      if text.present?
        csv = CSV.parse(text)
        marks_divisions = csv[0]
        csv.each_with_index do |row, row_index|
          if row_index > 0
            puts "Row: =============================================== #{row.inspect} ========================================="
            rollnumber = row[0].strip
            student = Student.find_by_rollnumber(rollnumber)
            puts "Student:========================================= #{student.inspect} ========================================="
            marks_divisions.each_with_index do |division, division_index|

              puts "Division Name: ========================================= #{division} ========================================="
              if division.present? and division.respond_to?(:to_i) and division.to_i == 0 and division != 'Names' and student.present?
                marks_division = @setting.marks_divisions.find_by_name(division.strip)
                puts "Marks Division: ========================================= #{marks_division.inspect} ========================================="
                report_card_subject = @setting.subjects.find_by(name: @subject.name, code: @subject.code) if @subject.present?
                report_card = ReportCard.find_by student_id: student.id, grade_id: @class.id, batch_id: Batch.last.id
                puts "Found Report Card: #{report_card.inspect}"

                if marks_division.present? and report_card_subject.present? and student.present? and report_card.present?
                  puts '==========================Entering Marks ============================================'
                  mark = Mark.find_or_create_by(report_card_id: report_card.id, exam_id: @exam.id,
                                                subject_id: report_card_subject.id, division_id: marks_division.id)

                  puts "Found Mark: #{mark.inspect}"
                  sessional = Sessional.find_or_create_by name: "#{marks_division.name} 1", mark_id: mark.id
                  puts "Division Index: #{division_index}"
                  puts "File Marks: #{row[division_index].try(:to_f)}"
                  sessional.update( obtained_marks: row[division_index].try(:to_f), mark_date: Date.today)
                  mark.update(obtained_marks: mark.sessionals.average(:obtained_marks), passing_marks: marks_division.passing_marks, total_marks: marks_division.total_marks)
                end
              end
            end
          end
        end
        flash[:alert] = 'Marks Uploaded Successfully.'
      else
        flash[:alert] = 'Bad Format. Please See the Sample File.'
      end
    rescue
      flash[:notice] = 'Bad Format. Please See the Sample File.'
    end

    redirect_to select_subject_and_exam_path(@class.id, current_user.id)
  end

  def download_sample
    @class      = Grade.find(params[:class_id])     if params[:class_id].present?
    @main_grade = @class.parent if @class.present?
    @exam       = Exam.find(params[:exam_id])       if params[:exam_id].present?
    @subject    = Subject.find(params[:subject_id]) if params[:subject_id].present?
    @setting    = ReportCardSetting.find_by(grade_id: @main_grade.id,
                                            batch_id: Batch.last.id, exam_id: @exam.id) if @main_grade.present?
    @employee  = Employee.find_by_email(current_user.email)

    csv_string = CSV.generate do |csv|

      division_array = ['', 'Names']
      @setting.marks_divisions.where(is_divisible: true).try(:each) do |division|
        division_array << division.name
      end

      @setting.marks_divisions.where(is_divisible: false).try(:each) do |division|
        division_array << division.name
      end
      csv << division_array

      @class.students.try(:each) do |student|
        csv << ["#{student.rollnumber}", "#{student.fullname}"]
      end
    end

    send_data csv_string, type: 'application/csv', filename: 'sample.csv'
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
