class AddColumnsToReportCard < ActiveRecord::Migration
  def change
    add_column :report_cards, :quarter_result_url, :string
    add_column :report_cards, :final_result_url, :string
  end
end
