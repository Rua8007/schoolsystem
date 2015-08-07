class Mark < ActiveRecord::Base
	belongs_to :grade
	has_many :sessionals
end
