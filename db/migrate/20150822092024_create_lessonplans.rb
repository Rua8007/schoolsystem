class CreateLessonplans < ActiveRecord::Migration
  def change
    create_table :lessonplans do |t|
      t.integer :grade_id
      t.integer :subject_id
      t.string :topic
      t.string :selection
      t.string :startdate
      t.string :enddate
      t.text :studentengage
      t.text :newvocabulary
      t.text :objectives

      t.timestamps null: false
    end
  end
end
