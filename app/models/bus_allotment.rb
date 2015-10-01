class BusAllotment < ActiveRecord::Base
	belongs_to :transport
	belongs_to :route
	belongs_to :student
	belongs_to :stop
  has_many :transportfeerecords
end
