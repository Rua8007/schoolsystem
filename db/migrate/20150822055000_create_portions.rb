class CreatePortions < ActiveRecord::Migration
  def change
    create_table :portions do |t|
      t.integer :year_plan_id
      t.string :quarter

      t.timestamps null: false
    end
  end
end
