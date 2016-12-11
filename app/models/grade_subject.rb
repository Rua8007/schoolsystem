class GradeSubject < ActiveRecord::Base

	belongs_to :subject
	belongs_to :grade
	belongs_to :week

	def subject_name
		self.try(:subject).try(:name)
	end
end
