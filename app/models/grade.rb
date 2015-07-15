class Grade < ActiveRecord::Base
	belongs_to :batch
	has_many :bridges
	has_many :subjects ,through: :bridges
end
