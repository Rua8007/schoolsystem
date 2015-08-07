class Item < ActiveRecord::Base
	belongs_to :grade
	belongs_to :item
end
