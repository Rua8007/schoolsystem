class Bridge < ActiveRecord::Base
	belongs_to :grade
	belongs_to :subject
	belongs_to :employee
	has_many :marksheets
	has_many :examcalenders
  has_many :performances
	has_many :sessionals

	LIST_HEADER = [ {label: 'subject_name',   method: 'subject_name'},
									{label: 'teacher_name',   method: 'teacher_name'},
									{label: 'teacher_email',  method: 'teacher_email'},
									{label: 'teacher_mobile', method: 'teacher_mobile'},
	]

	def title
		self.grade.full_name+'-'+self.subject.name
	end

	def subject_name
		subject.try(:name)
  end

  def teacher_name
    employee.try(:full_name)
  end

  def teacher_mobile
    employee.try(:mobile_number)
  end

  def teacher_email
    employee.try(:email)
  end
end
