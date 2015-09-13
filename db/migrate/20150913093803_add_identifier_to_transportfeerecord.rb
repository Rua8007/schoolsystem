class AddIdentifierToTransportfeerecord < ActiveRecord::Migration
  def change
    add_column :transportfeerecords, :identifier, :integer
  end
end
