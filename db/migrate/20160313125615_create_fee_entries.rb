class CreateFeeEntries < ActiveRecord::Migration
  def change
    create_table :fee_entries do |t|
      t.string :name
      t.float :total_amount
      t.boolean :mandatory
      t.integer :grade_id

      t.timestamps null: false
    end
  end
end
