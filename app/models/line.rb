class Line < ActiveRecord::Base
	belongs_to :items
	has_many :packages
	belongs_to :invoice   
end
