class AddNameToSessional < ActiveRecord::Migration
  def change
    add_column :sessionals , :name, :string
  end
end
