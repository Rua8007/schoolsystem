class Mark < ActiveRecord::Base
	belongs_to :grade_group
	has_many :sessionals
end
