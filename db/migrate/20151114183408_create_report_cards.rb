class CreateReportCards < ActiveRecord::Migration
  def change
    create_table :report_cards do |t|
      t.belongs_to :student
      t.belongs_to :grade
      t.text :remarks

      t.timestamps null: false
    end
  end
end
