class CreateReportCardHeadings < ActiveRecord::Migration
  def change
    create_table :report_card_headings do |t|
      t.integer :setting_id
      t.string  :label
      t.string  :method
      t.boolean :show
    end
  end
end
