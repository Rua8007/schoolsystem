class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :name
      t.integer :route_id

      t.timestamps null: false
    end
  end
end
