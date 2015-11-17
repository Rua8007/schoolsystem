class Mark < ActiveRecord::Base
	belongs_to :exam
	belongs_to :subject
	belongs_to :marks_division
	belongs_to :report_card

	has_many :sessionals

	accepts_nested_attributes_for :sessionals, reject_if: :all_blank, allow_destroy: true
end
