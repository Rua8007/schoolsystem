class YearPlan < ActiveRecord::Base

	has_many :weeks
	has_many :portions
	has_many :lessonplans
end
