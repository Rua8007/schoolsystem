class Vehicle < ActiveRecord::Base
	has_many :transports
	has_many :routes ,through: :transports
end
