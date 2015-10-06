class AddDiscountToStudent < ActiveRecord::Migration
  def change
    add_column :students, :discount, :float
  end
end
