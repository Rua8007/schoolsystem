class AddPurchasePriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :purchase, :float
  end
end
