class Line < ActiveRecord::Base
	has_many :packages
	belongs_to :invoice 
	belongs_to :item
end
