class Employee < ActiveRecord::Base

	has_many :employee_attendances
	has_many :leaves

	belongs_to :category
	belongs_to :position
	belongs_to :department

	has_many :bridges
	has_many :subjects ,through: :bridges

	has_many :transports
	has_many :routes ,through: :transports

	has_many :marksheets
	
	has_many :transports
	
end
