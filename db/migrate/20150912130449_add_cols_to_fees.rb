class AddColsToFees < ActiveRecord::Migration
  def change
    add_column :fees, :feebreakdown_id, :integer
    add_column :fees, :category, :string
  end
end
