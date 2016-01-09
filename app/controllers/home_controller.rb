class HomeController < ApplicationController

  def index
    if current_user.role.name == 'Parent'
      @temp2 = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @parent = @student.parent
      @student_no = @student.rollnumber

      @bridges = Bridge.where(grade_id: @student.grade_id) if @student.present?
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
      msg = params[:msgbdy]
      if params[:all]
        emails = Employee.pluck(:email) + Parent.pluck(:email) rescue []
        EmailService.new.delay.send_email(emails, msg)
      else
        emails = []
        if params[:parent].present?
          emails = emails + Parent.pluck(:email) rescue []
        end
        if params[:staff].present?
          emails = emails + Employee.pluck(:email)
        end
        if params[:student].present?
          student_ids = params[:students]
          student_ids.try(:each) do |std_id|
            std = Student.find(std_id)
            emails << std.email if std.present?
          end
        end

        if params[:grade].present?
          grade_ids = params[:grades]
          grade_ids.try(:each) do |grade_id|
            students = Student.where(grade_id: grade_id)
            emails = emails + students.pluck(:email) if students.present?
          end
        end

        emails = emails.compact
        EmailService.new.delay.send_email(emails, msg)
      end
      result = true
    end

    if params[:sms]
      send_to = ''
      if params[:all]
        number = Employee.all.pluck(:mobile_number) + Parent.all.pluck(:mobile)
        send_to = number.join(',')
        result = SmsService.new.delay.sendsms(params[:msgbdy], send_to)
      else
        if params[:parent].present?
          parents_numbers = Parent.all.pluck(:mobile).join(',')
          result = SmsService.new.delay.sendsms(params[:msgbdy], parents_numbers)
        end

        if params[:staff].present?
          employee_numbers = Employee.all.pluck(:mobile_number).join(',')
          result = SmsService.new.delay.sendsms(params[:msgbdy], employee_numbers)
        end

        student_numbers = []
        if params[:student].present?
          student_numbers = []
          student_ids = params[:students]
          student_ids.try(:each) do |std_id|
            std = Student.find(std_id)
            student_numbers << std.mobile if std.present?
          end
          student_numbers = student_numbers.compact.join(',')
          result = SmsService.new.delay.sendsms(params[:msgbdy], student_numbers) if student_numbers.present?
        end

        if params[:grade].present?
          student_numbers = []
          grade_ids = params[:grades]
          grade_ids.try(:each) do |grade_id|
            students = Student.where(grade_id: grade_id)
            student_numbers = student_numbers + students.pluck(:mobile) if students.present?
          end
          student_numbers = student_numbers.compact.join(',')
          result = SmsService.new.delay.sendsms(params[:msgbdy], student_numbers) if student_numbers.present?
        end
      end
    end
    flash[:notice] = 'Notifications sent.'
    redirect_to home_sms_path()
  end

end