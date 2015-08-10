class Package < ActiveRecord::Base
	belongs_to :grade

	has_many :packageitems

	accepts_nested_attributes_for :packageitems
	
end
