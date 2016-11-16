class Performance < ActiveRecord::Base
	belongs_to :student
	belongs_to :bridge

	def self.max_allowed
		5
	end
end
