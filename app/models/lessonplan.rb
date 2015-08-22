class Lessonplan < ActiveRecord::Base
	belongs_to :year_plan
	has_many :lessonplan_details
	belongs_to :subject
	belongs_to :grade

end
