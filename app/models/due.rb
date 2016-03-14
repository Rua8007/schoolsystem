class Due < ActiveRecord::Base
  belongs_to :feeable, polymorphic: true
  belongs_to :student
  belongs_to :grade
end
