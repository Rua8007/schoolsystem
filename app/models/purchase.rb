class Purchase < ActiveRecord::Base
	belongs_to :employee
	belongs_to :grade
	has_many :purchaselines
end
