class Packageitem < ActiveRecord::Base
	belongs_to :package
	belongs_to :item
end
