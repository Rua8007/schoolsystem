class HomeController < ApplicationController

  def index
     if current_user && current_user.role.name == 'Parent'  && current_user.sign_in_count <2
       @temp2 = Student.find_by_rollnumber(current_user.email.split('@').first.split('_').last).id 
       redirect_to edit_student_path(@temp2)

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