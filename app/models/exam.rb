class Exam < ActiveRecord::Base
	belongs_to :batch
	has_many :marksheets
end
