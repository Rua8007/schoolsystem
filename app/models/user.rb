class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

   acts_as_messageable

  belongs_to :role

  def mailboxer_email(object)
 #return the model's email here
  end


end
