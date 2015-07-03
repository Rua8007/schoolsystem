class Employee < ActiveRecord::Base

	belongs_to :category

	belongs_to :position

	belongs_to :department

end
