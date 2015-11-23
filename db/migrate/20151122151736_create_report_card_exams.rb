class CreateReportCardExams < ActiveRecord::Migration
  def change
    create_table :report_card_exams do |t|
      t.integer :setting_id
      t.string :name
      t.integer :batch_id

      t.timestamps null: false
    end
  end
end
