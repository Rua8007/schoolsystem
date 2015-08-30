class Result < ActiveRecord::Base
	has_many :marksheets
	belongs_to :bridge
	belongs_to :exam
end
