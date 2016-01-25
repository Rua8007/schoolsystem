require 'email_templates/student_email'
require 'email_templates/parent_email'
require 'email_templates/employee_email'
class EmailService

  def initialize(params)
    @params = params
  end

  def send_email
    if @params[:all_students]
      send_to_all(@params[:msgbdy], 'Student')
    end

    if @params[:all_employees]
      send_to_all(@params[:msgbdy], 'Employee')
    end

    if @params[:all_parents]
      send_to_all(@params[:msgbdy], 'Parent')
    end

    if @params[:parent].present?
      send_to_parents @params[:msgbdy], @params[:parents]
    end

    if @params[:staff].present?
      send_to_employees @params[:msgbdy], @params[:staff_members]
    end

    if @params[:student].present?
      send_to_students @params[:msgbdy], @params[:students]
    end

    if @params[:grade].present?
      grade_ids = @params[:grades]
      student_ids = []
      grade_ids.try(:each) do |grade_id|
        students = Student.where(grade_id: grade_id)
        student_ids = student_ids + students.pluck(:id) if students.present?
      end
      send_to_students @params[:msgbdy], student_ids
    end
  end

  def send_to_all(msg, klass)
    klass.constantize.all.each do |object|
      "#{klass}Email".constantize.template = msg
      email_msg = "#{klass}Email".constantize.new(object).render
      NotificationMailer.generic_email(object.email, email_msg).deliver if object.email.present?
    end
  end

  def send_to_parents(msg, student_ids)
    student_ids.try(:each) do |std_id|
      std = Student.find(std_id)
      parent = std.parent if std.present?
      ParentEmail.template = msg
      email_msg = ParentEmail.new(parent).render if parent.present?
      NotificationMailer.generic_email(parent.email, email_msg).deliver if parent.present? and parent.email.present?
    end
  end

  def send_to_students(msg, student_ids)
    student_ids.try(:each) do |std_id|
      std = Student.find(std_id)
      StudentEmail.template = msg
      email_msg = StudentEmail.new(std).render if std.present?
      NotificationMailer.generic_email(std.email, email_msg).deliver if std.present? and std.email.present?
    end
  end

  def send_to_employees(msg, employee_ids)
    employee_ids.try(:each) do |employee_id|
      employee = Employee.find(employee_id)
      EmployeeEmail.template = msg
      email_msg = EmployeeEmail.new(employee).render if employee.present?
      NotificationMailer.generic_email(employee.email, email_msg).deliver if employee.present? and employee.email.present?
    end
  end
end