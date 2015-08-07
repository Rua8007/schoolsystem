class Week < ActiveRecord::Base
	has_many :grade_subjects
	belongs_to :year_plan
end
