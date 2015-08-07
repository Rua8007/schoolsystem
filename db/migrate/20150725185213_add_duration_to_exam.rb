class AddDurationToExam < ActiveRecord::Migration
  def change
    add_column :exams, :start_date, :string
    add_column :exams, :end_date, :string
  end
end
