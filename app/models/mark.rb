class Mark < ActiveRecord::Base
	belongs_to :report_card_exam, foreign_key: 'exam_id'
	belongs_to :report_card_subject, foreign_key: 'subject_id'
	belongs_to :report_card_division, foreign_key: 'division_id'
	belongs_to :report_card

	has_many :sessionals

	accepts_nested_attributes_for :sessionals, reject_if: :all_blank, allow_destroy: true
end
