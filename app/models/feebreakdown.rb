class Feebreakdown < ActiveRecord::Base
	belongs_to :grade
  has_many :fees
end
