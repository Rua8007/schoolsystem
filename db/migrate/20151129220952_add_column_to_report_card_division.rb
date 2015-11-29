class AddColumnToReportCardDivision < ActiveRecord::Migration
  def change
    add_column :report_card_divisions, :is_divisible, :boolean
  end
end
