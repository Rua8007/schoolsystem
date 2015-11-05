class AddColsToAssociation < ActiveRecord::Migration
  def change
    add_column :associations, :lectures, :integer
  end
end
