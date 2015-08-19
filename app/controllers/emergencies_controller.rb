class EmergenciesController < ApplicationController
	 before_action :set_emergency, only: [:show, :edit, :update, :destroy]
  def new
  	@emergency = Emergency.new
  end

  def index
  	@emergency = Emergency.all
  end

  def create
    eme = Student.find(params[:student_id]).emergency.create(emergency_params)
    eme.save
    
    
    redirect_to new_document_path(student_id: @student.id)
  end

  def edit 
    
  end


  def show
  end

  private 
  def emergency_params
    params.require(:emergency).permit(:name, :phome, :mobile, :email, :student_id)
  end
end
