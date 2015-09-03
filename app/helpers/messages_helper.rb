module MessagesHelper
 def recipients_options
    s = ''
    User.all.each do |user|
       s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.email}</option>"
    end
    s.html_safe
  end

  def unread_messages_count
    # how to get the number of unread messages for the current user
    # using mailboxer
      current_user.mailbox.inbox(:unread => true).count(:id, :distinct => true)
    
  end
end