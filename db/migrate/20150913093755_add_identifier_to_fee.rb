class AddIdentifierToFee < ActiveRecord::Migration
  def change
    add_column :fees, :identifier, :integer
  end
end
