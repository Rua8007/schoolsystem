class AddNewColumnsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :forthname, :string
    add_column :students, :fifthname, :string
    add_column :students, :arabicname, :string
    add_column :students, :weight, :string
    add_column :students, :height, :string
    add_column :students, :eyeside, :string
    add_column :students, :hearing, :string
    add_column :students, :rh, :string
    add_column :students, :alergy, :string
    add_column :students, :nurology, :string
    add_column :students, :physical, :string
    add_column :students, :disability, :string
    add_column :students, :behaviour, :string
  end
end
