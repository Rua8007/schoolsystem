class StudentsController < ApplicationController
	def index
		@students = Student.all
    @student = @students.first
	end

	def new
		@student = Student.new
	end

  def create
    @student = Student.create(create_params)
    if @student
      emergency = @student.emergencies.create
      emergency.name = params[:student][:emergency][:name]
      emergency.mobile = params[:student][:emergency][:mobile]
      emergency.phone = params[:student][:emergency][:phone]
      emergency.email = params[:student][:emergency][:email]
      emergency.save

      fee = @student.fees.create
      fee.amount = params[:amount]
      fee.month = params[:month]
      fee.save

      redirect_to new_parent_path(student_id: @student.id), notice: "Student added"
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

  def assignParent
    # return render json: params
    std = Student.find(params[:id])
    std.parent_id = params[:student][:parent_id]
    std.save!
    redirect_to new_document_path(student_id: std.id)
  end

  def show
    @student = Student.find(params[:id])
    @parent = @student.parent
  end

  def detail
    puts "-"*80
    puts params
    puts "-"*80

    @student = Student.find(params[:id])
    if params[:fee]
      respond_to do |format|
        format.json {render json: @student}
      end
    else
      respond_to do |format|
        format.js
        format.json { render json: {student: @student } }  # respond with the created JSON object
      end
    end
  end
	private

    def create_params
      params.require(:student).permit(:fullname,:remote_image_url,:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :due_date, :image,:iqamaNumber,:iqamaExpiry, :previousInstitute, :year, :totalMarks, :obtainedMarks, :forthname, :fifthname, :arabicname, :weight,:height,:eyeside,:hearing,:rh,:alergy,:nurology,:physical,:disability,:behaviour, emergencies_attributes:[:name, :phome, :mobile, :email, :student_id])      
    end
end

