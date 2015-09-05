class MessagesController < ApplicationController

before_action :authenticate_user!

  def new
  end

  def create
  	if params['parent']
	  	parent = Student.where(id: params['recipients']).first.parent
	    recipients = User.where(email: parent.email)
	else
    	recipients = User.where(id: params['recipients'])
    end
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
  

  
end