class AddFullNameToStudent < ActiveRecord::Migration
  def change
    add_column :students, :fullname, :string
  end
end
