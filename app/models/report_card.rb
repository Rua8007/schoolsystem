class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade
  belongs_to :setting, class_name: 'ReportCardSetting', foreign_key: 'setting_id'
  has_many   :marks
end
