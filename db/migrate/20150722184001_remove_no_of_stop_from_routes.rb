class RemoveNoOfStopFromRoutes < ActiveRecord::Migration
  def change
    remove_column :routes, :no_of_stop, :string
  end
end
