class Examcalender < ActiveRecord::Base
	belongs_to :bridge
	belongs_to :grade
end
