class AddColorToReportCardHeadings < ActiveRecord::Migration
  def change
    add_column :report_card_headings, :color, :string
  end
end
