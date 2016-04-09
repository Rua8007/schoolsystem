class AddTakeExamToReportCardSubject < ActiveRecord::Migration
  def change
    add_column :report_card_subjects, :take_exam, :boolean
  end
end
