class Package < ActiveRecord::Base
	belongs_to :grade

	has_many :packageitems
	has_many :lines

	accepts_nested_attributes_for :packageitems
	
end
