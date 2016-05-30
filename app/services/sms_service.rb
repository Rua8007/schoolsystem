require 'sms_templates/student_sms'
require 'sms_templates/parent_sms'
require 'sms_templates/employee_sms'

class SmsService
  def self.send_message(body, send_to)
    puts "================in send sms=============="

    puts body
    body = body.gsub("&nbsp;", " ")
    body = body.gsub("<br>", "\n")
    puts body

    puts "================in send sms=============="
    puts "================in send sms=============="

    # response = HTTParty.post('http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=Al-omam&message=testing&MobileNo=+923134145612&txtlang=1')
    response = HTTParty.post("http://rest.dreamsms.net/sms",
              {
                :body => {:UserName => 'nations', :Password => 'nations@2016', :SenderName => 'AlOmamSch', :Message => body, :Mobiles => send_to}.to_json,
                :headers => { 'Content-Type' => " application/json", 'accept' => 'application/json charset=utf-8'}
              })
    # return render json: response
    # http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=Drea mSMS&message=test&MobileNo=541847555&txtlang=1
    puts '============================================'
    puts response
    puts '============================================'
    response
  end


  def initialize(params)
    @params = params
  end

  def send_sms
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
      "#{klass}Sms".constantize.template = msg
      sms_msg = "#{klass}Sms".constantize.new(object).render
      mobile = object.class == Employee ? object.mobile_number : object.mobile
      SmsService.send_message(sms_msg, mobile) if mobile.present?
    end
  end

  def send_to_parents(msg, student_ids)
    student_ids.try(:each) do |std_id|
      std = Student.find(std_id)
      parent = std.parent if std.present?
      ParentSms.template = msg
      sms_msg = ParentSms.new(parent).render if parent.present?
      SmsService.send_message(sms_msg, parent.mobile) if parent.present? and parent.mobile.present?
    end
  end

  def send_to_students(msg, student_ids)
    student_ids.try(:each) do |std_id|
      std = Student.find(std_id)
      StudentSms.template = msg
      sms_msg = StudentSms.new(std).render if std.present?
      SmsService.send_message(sms_msg, std.mobile) if std.present? and std.mobile.present?
    end
  end

  def send_to_employees(msg, employee_ids)
    employee_ids.try(:each) do |employee_id|
      employee = Employee.find(employee_id)
      EmployeeSms.template = msg
      sms_msg = EmployeeSms.new(employee).render if employee.present?
      SmsService.send_message(sms_msg, employee.mobile_number) if employee.present? and employee.mobile_number.present?
    end
  end
end