class GradeGroup < ActiveRecord::Base
  has_many :marks_divisions, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  accepts_nested_attributes_for :marks_divisions, reject_if: :all_blank, allow_destroy: true

end
