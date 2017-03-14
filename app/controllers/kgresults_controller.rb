class KgresultsController < ApplicationController
	def enter_marks
		@grade = Grade.find(params[:grade_id])
		@exam = Exam.find(params[:exam_id])
		@students = @grade.students
		@subject = Subject.find(params[:subject_id])
		@kgresults = Kgresult.where(grade_id: @grade.id, exam_id: @exam.id, subject_id: @subject.id)
		# return render json: @kgresults
		@marks_options = ["n/a","1","2","3","4","5"]
	end

	def save_kg_marks
		divisions = params[:sessionals].keys

		@class = Grade.find(params[:class_id])
		@exam = Exam.find(params[:exam_id])
		@subject = Subject.find(params[:subject_id])

		divisions.try(:each) do |student_id|
			result_row = Kgresult.find_or_create_by(exam_id: params[:exam_id], student_id: student_id, grade_id: params[:class_id], subject_id: params[:subject_id])
			result_row = result_row.update_attributes!(save_kgresult_params[student_id])
		end
    Notification.create(user_id: current_user.id, activity: "Entered marks for #{@exam.name}, #{@class.full_name} #{@subject.name}")
		redirect_to enter_marks_kgresults_path(grade_id: params[:class_id], exam_id: params[:exam_id], subject_id: params[:subject_id] ), notice: "Marks has been saved successfully!!"
	end

	def show
		@kgresult = Kgresult.find(params[:id])
		# return render json: @kgresult.grade_id
		@class = Grade.find(@kgresult.grade_id) 
		@exam = Exam.find(@kgresult.exam_id) 
		@std = Student.find(@kgresult.student_id) 
		@kgresults = Kgresult.where(subject_id: @kgresult.subject_id, exam_id: @exam.id, student_id: @std.id, grade_id: @class.id )
    respond_to do |format|
    	format.html
			format.pdf{
        render pdf: "#{@std.fullname}_#{@exam.name}_#{@class.full_name}", template: 'kgresults/get_kg_report.pdf.erb',
               layout: 'pdf.html.erb', margin: { top: 30, bottom: 11, left: 5, right: 5},
               header: { html: { template: 'shared/pdf_portrait_header.html.erb'} }, show_as_html: false,
               footer: { html: { template: 'shared/pdf_portrait_footer.html.erb'} }
      }
    end
	end

	def index
		@grades = Grade.where("name IN (?) AND section IS NOT NULL", ["KG", "KG2", "KG3"])
		# return render json: @grades
		@grade = params[:grade_id] ? Grade.find(params[:grade_id]) : Grade.where("name = ? AND section IS NOT NULL", "KG2").first
		@main_grade = @grade.parent
		@subjects = []
		@grade.bridges.each do |bridge|
      @subjects << bridge.subject
    end
    @exams = @main_grade.exams
    @subject = params[:subject_id] ? Subject.find(params[:subject_id]) : @subjects.first
		@exam = params[:exam_id] ? Exam.find(params[:exam_id]) : @main_grade.exams.where(batch_id: Batch.last.id).first
		@kgresults = Kgresult.where(exam_id: @exam.id , grade_id: @grade.id, subject_id: @subject.id)
		# return render json: @kgresults
	end

	def get_exams_and_subjects
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

	def fetch_kg_results
    @class = Grade.find(params[:class_id])
    @main_grade = @class.parent if @class.present?
    @exam = Exam.find_by_id(params[:exam_id])
    @subject = Subject.find(params[:subject_id])
    @teacher = @class.bridges.where(subject_id: Subject.find_by_name(@subject.name)).last.employee || nil
    @kgresults = Kgresult.where(exam_id: @exam.id, subject_id: @subject.id, grade_id: @class.id)
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

	def get_grade_bridges(current_user, grade_id)
    if current_user.role.rights.where(value: 'enter_all_marks').any?
      bridges = Bridge.where(grade_id: grade_id)
    else
      bridges = Bridge.where(grade_id: grade_id, employee_id: (Employee.find_by_email(current_user.email) || current_user).id )
    end
    bridges
  end

private
	def save_kgresult_params
		params.require(:sessionals).permit!
	end	
end
