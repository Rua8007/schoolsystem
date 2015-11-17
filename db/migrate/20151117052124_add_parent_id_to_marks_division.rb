class AddParentIdToMarksDivision < ActiveRecord::Migration
  def change
    add_column :marks_divisions, :parent_id, :integer
  end
end
