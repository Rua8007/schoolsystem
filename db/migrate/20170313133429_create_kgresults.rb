class CreateKgresults < ActiveRecord::Migration
  def change
    create_table :kgresults do |t|
      t.integer :exam_id
      t.integer :student_id
      t.integer :grade_id
      t.string :introduction
      t.string :behaviour
      t.string :speaking
      t.string :reading
      t.string :writing
      t.string :listening
      t.string :comprehension
      t.integer :subject_id
      t.string :subject
      t.string :conclusion

      t.timestamps null: false
    end
  end
end
