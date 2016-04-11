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



end