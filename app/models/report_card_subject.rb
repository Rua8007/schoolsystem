class ReportCardSubject < ActiveRecord::Base

  belongs_to :parent, class_name: 'ReportCardSubject'
  has_many :sub_subjects, foreign_key: 'parent_id', class_name: 'ReportCardSubject'
  accepts_nested_attributes_for :sub_subjects, reject_if: :all_blank, allow_destroy: true

  def self.find_by_subject(subject)
    parent = Subject.find(subject.parent_id) if subject.parent_id.present?
    report_card_parent = ReportCardSubject.find_by(name: parent.name, code: parent.code) if parent.present?
    find_or_create_by name: subject.name, code: subject.code, parent_id: report_card_parent.try(:id), weight: report_card_parent.try(:weight)
  end

end
