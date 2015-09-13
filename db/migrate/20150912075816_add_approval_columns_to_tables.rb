class AddApprovalColumnsToTables < ActiveRecord::Migration
  def change
  	add_column :curriculums, :approved, :boolean, :default => false
  	add_column :lessonplans, :approved, :boolean, :default => false
  	add_column :grade_subjects, :approved, :boolean, :default => false
  	add_column :portions, :approved, :boolean, :default => false
  end
end
