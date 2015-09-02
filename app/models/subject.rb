class Subject < ActiveRecord::Base
	has_many :bridges
	has_many :grades, through: :bridges

	has_many :grade_subjects
	has_many :portion_details
	has_many :lessonplans
	has_many :lessonplan_details
end
