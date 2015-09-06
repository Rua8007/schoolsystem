class CreateCurriculumDetails < ActiveRecord::Migration
  def change
    create_table :curriculum_details do |t|
      t.text :month
      t.integer :day
      t.string :sol
      t.string :strand
      t.text :content
      t.text :skill
      t.text :activity
      t.text :assessment
      t.integer :curriculum_id


      t.timestamps null: false
    end
  end
end
