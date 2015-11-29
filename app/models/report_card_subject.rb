class ReportCardSubject < ActiveRecord::Base

  belongs_to :parent, class_name: 'ReportCardSubject'
  has_many :sub_subjects, foreign_key: 'parent_id', class_name: 'ReportCardSubject'

  def self.find_by_subject(subject)
    find_or_create_by name: subject.name, code: subject.code, parent_id: subject.parent_id, weight: subject.weight
  end

end
