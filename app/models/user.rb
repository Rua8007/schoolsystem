class User < ActiveRecord::Base
  DEFAULT_PASSWORD = 'word2pass'
  LIST_HEADER = [ {label: 'email',             method: 'email'},
                  {label: 'role',              method: 'role_name'},
                  {label: 'status',            method: 'status'},
                  {label: 'login_count',       method: 'sign_in_count'},
                  {label: 'last_login_time',   method: 'last_sign_in_at'}
  ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

   acts_as_messageable

  belongs_to :role
  has_many :fees

  def mailboxer_email(object)
 #return the model's email here
  end

  def active_for_authentication?
    #remember to call the super
    #then put our own check to determine "active" state using
    #our own "is_active" column
    super and self.is_active?
  end

  def role_name
    self.role.try(:name)
  end

  def status
    is_active ? 'Enabled' : 'Disabled'
  end


end
