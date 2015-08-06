class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
