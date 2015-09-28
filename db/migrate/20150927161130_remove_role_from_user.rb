class RemoveRoleFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :role, :string
    add_column :users, :role_id, :integer
  end
end
