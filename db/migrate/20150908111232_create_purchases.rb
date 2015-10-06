class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :grade_id
      t.integer :employee_id
      t.text :detail
      t.boolean :approve

      t.timestamps null: false
    end
  end
end
