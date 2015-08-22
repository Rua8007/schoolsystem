class CreateLessonplanDetails < ActiveRecord::Migration
  def change
    create_table :lessonplan_details do |t|
      t.integer :subject_id
      t.integer :lessonplan_id
      t.string :period
      t.text :procedure

      t.timestamps null: false
    end
  end
end
