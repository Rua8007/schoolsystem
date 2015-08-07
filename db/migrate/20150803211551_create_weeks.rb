class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :year_plan_id
      t.date :start_date
      t.date :end_date
      t.string :holiday_description
      t.integer :year_week_id

      t.timestamps null: false
    end
  end
end
