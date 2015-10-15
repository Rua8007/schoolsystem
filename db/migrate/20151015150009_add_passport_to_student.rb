class AddPassportToStudent < ActiveRecord::Migration
  def change
    add_column :students, :passport, :string
  end
end
