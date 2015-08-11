class AddPackageToLine < ActiveRecord::Migration
  def change
    add_column :lines, :package_id, :integer
  end
end
