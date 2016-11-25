class AddSubmitterIdToPerformace < ActiveRecord::Migration
  def change
    add_column :performances, :submitted_by, :integer
  end
end
