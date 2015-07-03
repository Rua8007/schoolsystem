class StudentsController < ApplicationController
	def index
		@students = Student.all
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
      redirect_to new_student_path, notice: "Student added"
    else
      redirect_to :back, :alert => "Fill the form again!"
    end
  end

	private
    def create_params
      params.require(:student).permit(:remote_image_url,:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :dueDate, :image, :previousInstitute, :year, :totalMarks, :obtainedMarks, :forthname, :fifthname, :arabicname, :weight,:height,:eyeside,:hearing,:rh,:alergy,:nurology,:physical,:disability,:behaviour)      
    end
end

