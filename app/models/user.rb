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

  def receipent_options()
    user = []
    if self.role_name == 'Parent'
      student = Student.find_by_rollnumber(self.email.split('@').first.split('_').last)
      student.grade.bridges.each do |bridge|
        user << User.find_by_email(bridge.employee.email) if User.find_by_email(bridge.employee.email).present?
      end
      Role.where.not(name: ["Parent", "Teacher", "Student"]).each do |role|
        user += role.users
      end
      # user << User.joins(:role).where("roles.name != 'Parent' and roles.name != 'Teacher' and roles.name != 'Student' ")
    elsif self.role_name == 'Teacher'
      Employee.find_by_email(self.email).bridges.each do |bridge|
        bridge.grade.students.each do |std|
          user << User.find_by_email(std.email) if User.find_by_email(std.email).present?
        end
      end
      Role.where.not(name: ["Parent", "Teacher", "Student"]).each do |role|
        user += role.users
      end
    else
      user = User.all
    end
    puts "==========="
    puts user.uniq.inspect
    puts "==========="
    user.uniq
  end

  def status
    is_active ? 'Enabled' : 'Disabled'
  end


end
