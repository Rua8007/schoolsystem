class AddRoleToRights < ActiveRecord::Migration
  def change
    add_column :rights, :role_id, :integer
  end
end
