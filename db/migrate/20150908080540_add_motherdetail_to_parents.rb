class AddMotherdetailToParents < ActiveRecord::Migration
  def change
    add_column :parents, :mothername, :string
    add_column :parents, :mothermobile, :string
    add_column :parents, :motheremail, :string
  end
end
