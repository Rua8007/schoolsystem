class AddResultToMarksheet < ActiveRecord::Migration
  def change
    add_column :marksheets, :result_id, :integer
  end
end
