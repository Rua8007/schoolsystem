class Grade < ActiveRecord::Base
	belongs_to :batch
	has_many :bridges
	has_many :subjects ,through: :bridges
	has_many :students
	has_many :marks
	has_many :marksheets
	has_many :items
	has_many :packages
	has_many :portions
	has_many :lessonplans
	has_many :curriculums
	has_many :feebreakdowns
	has_many :purchases
	has_many :associations
	# has_many :subjects ,through: :associations


	has_many :grade_subjects
	has_many :examcalenders


	def full_name
	   "#{name} (#{section})"
	end
end
