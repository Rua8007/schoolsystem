class AddPriceToLine < ActiveRecord::Migration
  def change
    add_column :lines, :price, :float
  end
end
