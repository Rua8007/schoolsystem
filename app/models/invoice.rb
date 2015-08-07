class Invoice < ActiveRecord::Base
	has_many :lines
	belongs_to :items
	accepts_nested_attributes_for :lines
end
