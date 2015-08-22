class AddDetailsToPortionDetails < ActiveRecord::Migration
  def change
    add_column :portion_details, :details, :text
  end
end
