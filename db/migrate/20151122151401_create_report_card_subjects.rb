class CreateReportCardSubjects < ActiveRecord::Migration
  def change
    create_table :report_card_subjects do |t|
      t.integer :setting_id
      t.string :name
      t.string :code
      t.integer :parent

      t.timestamps null: false
    end
  end
end
