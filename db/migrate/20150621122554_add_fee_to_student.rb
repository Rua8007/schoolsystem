class AddFeeToStudent < ActiveRecord::Migration
  def change
    add_column :students, :fee, :integer
    add_column :students, :term, :string
    add_column :students, :dueDate, :string
  end
end
