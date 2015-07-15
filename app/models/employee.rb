class Employee < ActiveRecord::Base

	belongs_to :category

	belongs_to :position

	belongs_to :department

	has_many :bridges
	has_many :subjects ,through: :bridges

end
