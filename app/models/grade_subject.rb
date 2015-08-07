class GradeSubject < ActiveRecord::Base

	belongs_to :subject
	belongs_to :grade
	belongs_to :week
end
