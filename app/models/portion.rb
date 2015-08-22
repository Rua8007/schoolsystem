class Portion < ActiveRecord::Base
	belongs_to :year_plan

	has_many :portion_details
end
