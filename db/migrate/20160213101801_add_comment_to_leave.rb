class AddCommentToLeave < ActiveRecord::Migration
  def change
    add_column :leaves, :comment, :string
  end
end
