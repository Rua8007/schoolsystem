class AddColumnsToReportCardSetting < ActiveRecord::Migration
  def change
    add_column :report_card_settings, :exam_id, :integer
    add_column :report_card_settings, :report_type_id, :integer
  end
end
