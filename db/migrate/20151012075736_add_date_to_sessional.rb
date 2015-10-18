class AddDateToSessional < ActiveRecord::Migration
  def change
    add_column :sessionals, :mark_date, :string
  end
end
