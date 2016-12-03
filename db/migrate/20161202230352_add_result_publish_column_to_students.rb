class AddResultPublishColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :publish_result, :boolean, default: true
  end
end
