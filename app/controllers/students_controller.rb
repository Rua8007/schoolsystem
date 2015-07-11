class StudentsController < ApplicationController
	def index
		@students = Student.all
    @student = @students.first
	end

	def new
		@student = Student.new
	end

  def create
    # return render json: params.inspect
    @student = Student.create(create_params)
    if @student.save!
      # @student.amount = Grade.find(params[:student][:grade_id]).fee
      # @student.staus = ''
      # s = @student.save!

      #User.create!(email: @student.email, password: "school", user_type: 4, password_confirmation: "school")
      redirect_to new_parent_path(student_id: @student.id), notice: "Student added"
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

  def assignParent
    std = Student.find(params[:id])
    std.parent_id = params[:student][:parent_id]
    std.save!
    # redirect_to emergency_parent_path(student_id: std.id)
  end

  def show
    @student = Student.find(params[:id])
    @parent = @student.parent
  end

  def detail
    puts "-"*80
    puts "-"*80
    @student = Student.find(params[:id])
    respond_to do |format|
      format.js
      format.json { render json: {student: @student } }  # respond with the created JSON object
    end

  end
	private
    def create_params
      params.require(:student).permit(:remote_image_url,:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :dueDate, :image, :previousInstitute, :year, :totalMarks, :obtainedMarks, :forthname, :fifthname, :arabicname, :weight,:height,:eyeside,:hearing,:rh,:alergy,:nurology,:physical,:disability,:behaviour)      
    end
end

