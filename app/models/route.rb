class Route < ActiveRecord::Base
	belongs_to :vehicle
	has_many :stops

	has_many :transports
	has_many :bus_allotment
end
