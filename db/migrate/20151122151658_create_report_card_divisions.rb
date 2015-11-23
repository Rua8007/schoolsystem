class CreateReportCardDivisions < ActiveRecord::Migration
  def change
    create_table :report_card_divisions do |t|
      t.integer :setting_id
      t.string :name
      t.string :passing_marks
      t.string :float
      t.float :total_marks

      t.timestamps null: false
    end
  end
end
