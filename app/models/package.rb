class Package < ActiveRecord::Base
	has_many :grades

	has_many :packageitems

	accepts_nested_attributes_for :packageitems
	
end
