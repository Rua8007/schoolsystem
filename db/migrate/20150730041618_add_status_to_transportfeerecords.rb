class AddStatusToTransportfeerecords < ActiveRecord::Migration
  def change
    add_column :transportfeerecords, :status, :string
  end
end
