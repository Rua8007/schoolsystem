class Bridge < ActiveRecord::Base
	belongs_to :grade
	belongs_to :subject
	belongs_to :employee
	has_many :marksheets
	has_many :examcalenders
  has_many :performances
	has_many :sessionals

	def title
		self.grade.name+'-'+self.subject.name
	end
end
