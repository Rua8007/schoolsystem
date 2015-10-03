class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.integer :student_id
      t.integer :bridge_id
      t.text :remark

      t.timestamps null: false
    end
  end
end
