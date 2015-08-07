class CreateYearPlans < ActiveRecord::Migration
  def change
    create_table :year_plans do |t|
      t.string :year_name

      t.timestamps null: false
    end
  end
end
