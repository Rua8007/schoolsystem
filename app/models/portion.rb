class Portion < ActiveRecord::Base
	belongs_to :year_plan
	belongs_to :grade

	has_many :portion_details
end
