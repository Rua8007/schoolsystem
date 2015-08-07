class CreatePackageitems < ActiveRecord::Migration
  def change
    create_table :packageitems do |t|
      t.integer :package_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
