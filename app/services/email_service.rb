class EmailService
  def send_email(emails, msg)
    if emails.present?
      emails.each do |email|
        NotificationMailer.generic_email(email, msg).deliver if email.present?
      end
    end
  end
end