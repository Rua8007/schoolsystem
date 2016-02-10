class Role < ActiveRecord::Base
  has_many :users
  has_many :rights

  SUPER_USER_ROLE = 'superuser'
end
