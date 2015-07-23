class Transport < ActiveRecord::Base
	belongs_to :route
	belongs_to :vehicle
	belongs_to :employee
end
