class Leave < ActiveRecord::Base

	belongs_to :employee
	belongs_to :user
end
