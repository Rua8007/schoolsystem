class ReportCardSubject < ActiveRecord::Base
  def self.find_by_subject(subject)
    find_by name: subject.name, code: subject.code
  end
end
