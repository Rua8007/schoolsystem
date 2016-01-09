class NotificationMailer < ApplicationMailer
  default from: 'no-reply@alomam.edu.sa'

  #def generic_email(to, from, subject, body, attachment)
  def generic_email(to, msg)
    @msg = msg
    mail(to: to, subject: 'Al-Omam International', content_type: 'text/html')
  end
end
