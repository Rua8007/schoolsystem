class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :code
      t.float :price
      t.integer :sold

      t.timestamps null: false
    end
  end
end
