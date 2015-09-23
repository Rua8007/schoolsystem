class HomeController < ApplicationController

  def index
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