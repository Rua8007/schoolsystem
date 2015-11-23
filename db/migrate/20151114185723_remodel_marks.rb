class RemodelMarks < ActiveRecord::Migration
  def change
    remove_column :marks, :name, :string
    remove_column :marks, :marks, :float
    remove_column :marks, :grade_id, :integer

    add_column :marks, :exam_id, :integer
    add_column :marks, :subject_id, :integer
    add_column :marks, :division_id, :integer
    add_column :marks, :report_card_id, :integer

    add_column :marks, :total_marks, :float
    add_column :marks, :obtained_marks, :float
    # passing marks already present
  end
end
