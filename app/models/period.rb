class Period < ActiveRecord::Base
	belongs_to :time_table
	belongs_to :subject
end
