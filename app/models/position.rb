class Position < ActiveRecord::Base

	has_many :employees
	
	belongs_to :category
end
