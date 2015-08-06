class CreateShopcategories < ActiveRecord::Migration
  def change
    create_table :shopcategories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
