class Exam < ActiveRecord::Base
	belongs_to :batch
  has_many :marksheets
	has_many :sessionals

	before_create :unique_exam

	def unique_exam
		if Exam.where(grade_id: self.grade_id, name: self.name, batch_id: self.batch_id).present?
      errors.add(:name, "#{self.name} is already present for this grade.")
      false
    else
      true
    end
  end

end
