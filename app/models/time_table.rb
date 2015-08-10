class TimeTable < ActiveRecord::Base
	belongs_to :grade
	belongs_to :employee
	has_many :periods
end
