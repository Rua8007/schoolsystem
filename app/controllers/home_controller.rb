class HomeController < ApplicationController

  def index
    if current_user.role.name == 'Parent'
      @temp2 = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @parent = @student.parent
      @student_no = @student.rollnumber

      @bridges = Bridge.where(grade_id: @student.grade_id) if @student.present?
    elsif current_user.role.name == 'Teacher'
      @categories = Category.order(:name)
      @departments = Department.order(:name)
      @employee = Employee.find_by_email(current_user.email)
      @bridges = @employee.bridges if @employee.present?
    end
  end

  def timetable
  end

  def sms
    redirect_to root_path unless Right.where("role_id = ? and value = 'send_sms'", current_user.role_id ).any?
  end

  def sendsms
    # return render json: params

    if params[:email]
      EmailService.new(params).delay.send_email
    end

    if params[:sms]
      SmsService.new(params).delay.send_sms
    end
    flash[:notice] = 'Notifications sent.'
    redirect_to home_sms_path()
  end

end