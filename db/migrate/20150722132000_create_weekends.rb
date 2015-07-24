class CreateWeekends < ActiveRecord::Migration
  def change
    create_table :weekends do |t|
      t.integer :weekend_day

      t.timestamps null: false
    end
  end
end
