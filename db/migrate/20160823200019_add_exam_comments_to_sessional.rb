class AddExamCommentsToSessional < ActiveRecord::Migration
  def change
    add_column :sessionals, :comments, :string
  end
end
