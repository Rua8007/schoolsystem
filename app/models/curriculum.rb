class Curriculum < ActiveRecord::Base
	belongs_to :grade
	belongs_to :subject
	belongs_to :year_plan
	has_many :curriculum_details
end
