class CreateReportCardSettings < ActiveRecord::Migration
  def change
    create_table :report_card_settings do |t|
      t.integer :grade_id
      t.integer :batch_id

      t.timestamps null: false
    end
  end
end
