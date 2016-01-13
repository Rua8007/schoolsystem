class SmsService
  def sendsms(body, send_to)
    # response = HTTParty.post('http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=Al-omam&message=testing&MobileNo=+923134145612&txtlang=1')
    response = HTTParty.post("http://rest.dreamsms.net/sms",
              {
                :body => {:UserName => 'nations', :Password => '123', :SenderName => 'Al Omam International', :Message => body, :Mobiles => send_to}.to_json,
                :headers => { 'Content-Type' => " application/json", 'accept' => 'application/json charset=utf-8'}
              })
    # return render json: response
    # http://dreamsms.net/sendHexEncoded.HTML?UserName=test9&Password=123&senderName=Drea mSMS&message=test&MobileNo=541847555&txtlang=1
    puts '============================================'
    puts response
    puts '============================================'
  end
end