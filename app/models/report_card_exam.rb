class ReportCardExam < ActiveRecord::Base

  def self.find_by_exam(exam)
    find_by name: exam.name, batch_id: exam.batch_id
  end
end
