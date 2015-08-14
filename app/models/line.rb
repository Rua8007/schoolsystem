class Line < ActiveRecord::Base
	belongs_to :package
	belongs_to :invoice 
	belongs_to :item
end
