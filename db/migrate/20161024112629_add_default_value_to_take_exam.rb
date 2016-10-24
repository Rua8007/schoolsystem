class AddDefaultValueToTakeExam < ActiveRecord::Migration
  def up
	  change_column_default :report_card_subjects, :take_exam, true
	end

	def down
	  change_column_default :report_card_subjects, :take_exam, nil
	end
end
