class CreatePurchaselines < ActiveRecord::Migration
  def change
    create_table :purchaselines do |t|
      t.integer :purchase_id
      t.string :code
      t.integer :quantity
      t.float :price

      t.timestamps null: false
    end
  end
end
