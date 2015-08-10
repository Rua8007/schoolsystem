class Invoice < ActiveRecord::Base
	belongs_to :items
	belongs_to :student
	has_many :lines

end
