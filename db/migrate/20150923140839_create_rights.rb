class CreateRights < ActiveRecord::Migration
  def change
    create_table :rights do |t|
      t.string :name
      t.string :value

      t.timestamps null: false
    end
  end
end
