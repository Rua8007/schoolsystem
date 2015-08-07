class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.integer :shopcategory_id
      t.string :size
      t.float :price
      t.integer :grade_id
      t.integer :sold
      t.integer :left

      t.timestamps null: false
    end
  end
end
