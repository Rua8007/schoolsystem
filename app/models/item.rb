class Item < ActiveRecord::Base
	belongs_to :grade
	belongs_to :shopcategory
	
	has_many :packageitems

end
