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
    response = HTTParty.get('http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=DreamSMS&message=test&MobileNo=544479655&txtlang=1')
    return render json: response
    # http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=Drea mSMS&message=test&MobileNo=541847555&txtlang=1
  end

end