class ChangePassingMarksToFloat < ActiveRecord::Migration
  def change
    change_column :report_card_divisions, :passing_marks, 'float USING CAST(passing_marks AS DECIMAL(4,2))'
  end
end
