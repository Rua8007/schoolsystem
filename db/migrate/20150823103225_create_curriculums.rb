class CreateCurriculums < ActiveRecord::Migration
  def change
    create_table :curriculums do |t|
      t.integer :grade_id
      t.integer :subject_id
      t.text :studentname
      t.integer :year_plan_id
      

      t.timestamps null: false
    end
  end
end
