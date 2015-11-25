class CreateReportCards < ActiveRecord::Migration
  def change
    create_table :report_cards do |t|
      t.belongs_to :student
      t.belongs_to :grade
      t.belongs_to :batch
      t.belongs_to :setting
      t.text :remarks

      t.timestamps null: false
    end
  end
end
