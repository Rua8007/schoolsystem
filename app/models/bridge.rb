class Bridge < ActiveRecord::Base
	belongs_to :grade
	belongs_to :subject
	belongs_to :employee
end
