class Subject < ActiveRecord::Base
	has_many :bridges
	has_many :grades, through: :bridges

	has_many :grade_subjects
	has_many :portion_details
	has_many :lessonplans
	has_many :lessonplan_details

	has_many :marksheets, through: :bridges
	has_many :curriculums
  has_many :associations

	belongs_to :parent, class_name: 'Subject'
	has_many :sub_subjects, foreign_key: 'parent_id', class_name: 'Subject'

	accepts_nested_attributes_for :sub_subjects, reject_if: :all_blank, allow_destroy: true
  # has_many :grades,through: :associations

	validates_uniqueness_of :code
	validates_uniqueness_of :name, if: 'parent.nil?'
	validates_presence_of :name, :code
	validates_presence_of :weight, if: 'parent.present?'

end
