class DocumentsController < ApplicationController

skip_before_filter  :verify_authenticity_token
  
  def new
  	@document = Document.new
    @document.student_id = params[:student_id]
    @document1 = Document.new
    @document1.student_id = params[:student_id]
    @document2 = Document.new
    @document2.student_id = params[:student_id]
    
    @student = Student.find(params[:student_id])
  end

  def create
    # return render json: params[:student][:document][:attachment]
    puts '-'*80
  	document = Document.create(create_params)
    # render :nothing
   
  	# redirect_to new_document_path({student_id: document.student_id}), :notice => 'Docuemnt Uploaded successfully!'
  end

  def edit

  end
    
  


  def addPreviousInfo

    puts 'x'*80
    student = Student.find(params[:id])
    student.previousInstitute = params[:student][:previousInstitute]
    student.year = params[:student][:year]
    student.totalMarks = params[:student][:totalMarks]
    student.obtainedMarks = params[:student][:obtainedMarks]
    student.save

    render text: :mothing
  end

  def upload
   
    # return render json: params

    student = Student.find(params[:student_id])
    if !params[:attachment1].nil?
      doc1 = student.documents.create
      doc1.description = params[:description1]
      doc1.attachment = params[:attachment1]
      doc1.save
    end
    
    if !params[:attachment2].nil?
      doc1 = student.documents.create
      doc1.description = params[:description2]
      doc1.attachment = params[:attachment2]
      doc1.save
    end

    if !params[:attachment3].nil?
      doc1 = student.documents.create
      doc1.description = params[:description3]
      doc1.attachment = params[:attachment3]
      doc1.save
    end

    if !params[:attachment4].nil?
      doc1 = student.documents.create
      doc1.description = params[:description4]
      doc1.attachment = params[:attachment4]
      doc1.save
    end

    if !params[:attachment5].nil?
      doc1 = student.documents.create
      doc1.description = params[:description5]
      doc1.attachment = params[:attachment5]
      doc1.save
    end

    if !params[:attachment6].nil?
      doc1 = student.documents.create
      doc1.description = params[:description6]
      doc1.attachment = params[:attachment6]
      doc1.save
    end

    if !params[:attachment7].nil?
      doc1 = student.documents.create
      doc1.description = params[:description7]
      doc1.attachment = params[:attachment7]
      doc1.save
    end

    if !params[:attachment8].nil?
      doc1 = student.documents.create
      doc1.description = params[:description8]
      doc1.attachment = params[:attachment8]
      doc1.save
    end
     redirect_to student_path(student.id)

  end

  private
    def create_params
      params.require(:document).permit(:description, :attachment, :student_id)      
    end
end
