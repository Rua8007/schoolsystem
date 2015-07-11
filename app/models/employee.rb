class Employee < ActiveRecord::Base

	has_many :employee_attendances
	has_many :leaves

	belongs_to :category
	belongs_to :position
	belongs_to :department

	

end
