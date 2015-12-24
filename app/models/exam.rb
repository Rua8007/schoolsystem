class Exam < ActiveRecord::Base
	belongs_to :batch
  has_many :marksheets
	has_many :sessionals

	before_save :unique_exam

	def unique_exam
    exam = Exam.find_by(grade_id: self.grade_id, name: self.name, batch_id: self.batch_id)
		if exam.present? and exam.id != self.id
      errors.add(:name, "#{self.name} is already present for this grade.")
      false
    else
      true
    end
  end

end
