ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    Authentication: 'plain',
    enable_starttls_auto: true,
    user_name: "#{ENV['MAIL_FROM_ADDRESS']}",
    password: "#{ENV['MAIL_PASSWORD']}",
}