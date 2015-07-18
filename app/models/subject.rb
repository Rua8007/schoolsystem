class Subject < ActiveRecord::Base
	has_many :bridges
	has_many :grades, through: :bridges
end
