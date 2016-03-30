class Due < ActiveRecord::Base
  belongs_to :feeable, polymorphic: true
  belongs_to :student
  belongs_to :grade

  before_save :save_balance

  def save_balance
    self.balance = self.total - self.paid
  end
end
