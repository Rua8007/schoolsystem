class AddColumnToDues < ActiveRecord::Migration
  def change
    add_column :dues, :show, :boolean
  end
end
