class AddIsLockedToExams < ActiveRecord::Migration
  def change
    add_column :exams, :is_locked, :boolean, default: true
  end
end
