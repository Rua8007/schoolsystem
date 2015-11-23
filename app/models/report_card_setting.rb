class ReportCardSetting < ActiveRecord::Base
  has_many :subjects, class_name: 'ReportCardSubject', foreign_key: 'setting_id'
  has_many :exams, class_name: 'ReportCardExam', foreign_key: 'setting_id'
  has_many :marks_divisions, class_name: 'ReportCardDivision', foreign_key: 'setting_id'
end
