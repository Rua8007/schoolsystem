class Batch < ActiveRecord::Base
	has_many :grades
	has_many :exams
end
