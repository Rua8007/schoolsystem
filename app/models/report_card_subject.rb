class ReportCardSubject < ActiveRecord::Base
  def self.find_by_subject(subject)
    find_or_create_by name: subject.name, code: subject.code, parent_id: subject.parent_id, weight: subject.weight
  end
end
