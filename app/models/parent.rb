class Parent < ActiveRecord::Base
	has_many :students

	has_many :emergencies

	accepts_nested_attributes_for :emergencies
	
end
