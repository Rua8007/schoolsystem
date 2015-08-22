class AddYearPlanToLessonplans < ActiveRecord::Migration
  def change
    add_column :lessonplans, :year_plan_id, :integer
  end
end
