class Sessional < ActiveRecord::Base
	belongs_to :mark
	belongs_to :marksheet
  belongs_to :student
  belongs_to :bridge
  belongs_to :exam

end
