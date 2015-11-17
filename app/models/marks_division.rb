class MarksDivision < ActiveRecord::Base
  belongs_to :mark

  belongs_to :parent, class_name: 'MarksDivision'
  has_many :sub_divisions, foreign_key: 'parent_id', class_name: 'MarksDivision'

  accepts_nested_attributes_for :sub_divisions , reject_if: :all_blank, allow_destroy: true

end
