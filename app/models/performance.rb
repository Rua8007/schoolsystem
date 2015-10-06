class Performance < ActiveRecord::Base
	belongs_to :student
	belongs_to :bridge
end
