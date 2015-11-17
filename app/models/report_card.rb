class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade
  has_many   :marks
end
