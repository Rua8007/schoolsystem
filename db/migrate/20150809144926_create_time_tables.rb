class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.integer :grade_id
      t.integer :employee_id
      t.integer :break_after_period
      t.integer :prayer_after_period

      t.timestamps null: false
    end
  end
end
