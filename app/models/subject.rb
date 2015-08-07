class Subject < ActiveRecord::Base
	has_many :bridges
	has_many :grades, through: :bridges

	has_many :grade_subjects
end
