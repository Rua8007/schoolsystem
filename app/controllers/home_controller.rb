class HomeController < ApplicationController

  def index
    if current_user.role.name == 'Parent'
      @temp2 = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @student = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last)
      @parent = @student.parent
      @student_no = @student.rollnumber
    end
  end

  def timetable
  end

  def sms
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
          emails = Parent.pluck(:email)
        end
        if params[:staff].present?
          emails = Employee.pluck(:email)
        end
        EmailService.new.delay.send_email(emails, msg)
      end
      result = true
    end

    if params[:sms]
      send_to = ''
      if params[:all]

        employee_numbers = Employee.all.pluck(:mobile_number).collect { |n| n.to_s }.to_s
        employee_numbers = employee_numbers.gsub('[', '')
        employee_numbers = employee_numbers.gsub(']', '')

        parents_numbers = Parent.all.pluck(:mobile).collect { |n| n.to_s }.to_s
        parents_numbers = parents_numbers.gsub('[', '')
        parents_numbers = parents_numbers.gsub(']', '')

        send_to = employee_numbers + ',' + parents_numbers
        send_to = send_to.gsub(' ', '')
        send_to = send_to.gsub(',""', '')
        # send_to =  send_to.replace(/ /,'')
        # send_to =  send_to.replace(/,,/ , ',')

        # send_to =  send_to.replace(/,,/ , ',')
        # send_to =  send_to.replace(/,,/ , '')
        result = SmsService.new.delay.sendsms(params[:msgbdy], send_to)
      else
        if params[:parent].present?
          parents_numbers = Parent.all.pluck(:mobile).collect { |n| n.to_s }.to_s
          parents_numbers = parents_numbers.gsub('[', '')
          parents_numbers = parents_numbers.gsub(']', '')
          result = SmsService.new.delay.sendsms(params[:msgbdy], parents_numbers)
        end

        if params[:staff].present?
          employee_numbers = Employee.all.pluck(:mobile_number).collect { |n| n.to_s }.to_s
          employee_numbers = employee_numbers.gsub('[', '')
          employee_numbers = employee_numbers.gsub(']', '')
          result = SmsService.new.delay.sendsms(params[:msgbdy], employee_numbers)
        end
      end
    end
    flash[:notice] = 'Notifications sent.'
    redirect_to home_sms_path() if result
  end

end