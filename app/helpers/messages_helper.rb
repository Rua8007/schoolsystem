module MessagesHelper
 def recipients_options
    s = ''
    User.where(role: 'teacher').each do |user|
       s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{Employee.find_by_email(user.email).full_name}</option>"
    end
    s.html_safe
  end
end