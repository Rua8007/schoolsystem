class FeeEntry < ActiveRecord::Base
  belongs_to :grade
  validates :grade_id, :name, :total_amount, presence: true
end
