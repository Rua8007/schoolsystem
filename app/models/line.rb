class Line < ActiveRecord::Base
	has_many :items
	belongs_to :invoice   
end
