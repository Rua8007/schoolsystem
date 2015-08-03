class AddTransportDoToTransports < ActiveRecord::Migration
  def change
    add_column :transports, :no, :string
  end
end
