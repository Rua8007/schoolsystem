class Fee < ActiveRecord::Base
	belongs_to :student
  belongs_to :feebreakdown
  belongs_to :user
end