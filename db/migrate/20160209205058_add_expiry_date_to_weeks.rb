class AddExpiryDateToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :expiry_date, :date
  end
end
