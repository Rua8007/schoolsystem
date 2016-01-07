class EmailService
  def send_email(emails, msg)
    puts '================================'
    puts msg
    puts '================================'
    if emails.present?
      emails.each do |email|
        NotificationMailer.generic_email(email, msg).deliver
      end
    end
  end
end