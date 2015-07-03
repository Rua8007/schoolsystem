class Category < ActiveRecord::Base

	has_many :positions
	has_many :employees

end
