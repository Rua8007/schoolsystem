class AddTakeExamToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :take_exam, :boolean, default: true
  end
end
