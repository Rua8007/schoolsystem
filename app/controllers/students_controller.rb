class StudentsController < ApplicationController
	def index
		@students = Student.all
	end

	def new
		@student = Student.new
	end

	def create
		
	end

	private
    def create_params
      params.require(:student).permit(:first_name, :mobile, :address, :email, :grade_id, :dob,:gender,:middle_name, :last_name, :blood, :birth_place, :nationality, :language, :religion, :city, :state, :country,:phone, :fee, :term, :dueDate)      
    end
end
