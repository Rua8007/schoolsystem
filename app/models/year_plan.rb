class YearPlan < ActiveRecord::Base

	has_many :weeks
	has_many :portions
end
