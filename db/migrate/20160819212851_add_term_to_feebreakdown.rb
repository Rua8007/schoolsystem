class AddTermToFeebreakdown < ActiveRecord::Migration
  def change
    add_column :feebreakdowns, :term, :string
  end
end
