class DocumentsController < ApplicationController


  protect_from_forgery
  def new
  	@document = Document.new
    @document.student_id = params[:student_id]
    @student = Student.find(params[:student_id])
  end

  def create
    puts '-'*80
  	document = Document.create(create_params)
  	redirect_to new_document_path({student_id: document.student_id}), :notice => 'Docuemnt Uploaded successfully!'
  end

  def addPreviousInfo
    student = Student.find(params[:id])
    student.previousInstitute = params[:student][:previousInstitute]
    student.year = params[:student][:year]
    student.totalMarks = params[:student][:totalMarks]
    student.obtainedMarks = params[:student][:obtainedMarks]
    student.save

    render text: :mothing
  end

  private
    def create_params
      params.require(:document).permit(:description, :attachment, :student_id)      
    end
end
