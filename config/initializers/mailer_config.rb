ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :user_name => "#{ENV['MAIL_FROM_ADDRESS']}",
    :password => "#{ENV['MAIL_PASSWORD']}",
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}