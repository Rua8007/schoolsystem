class AddIqamaToStudent < ActiveRecord::Migration
  def change
    add_column :students, :iqamaNumber, :string
    add_column :students, :iqamaExpiry, :string
  end
end
