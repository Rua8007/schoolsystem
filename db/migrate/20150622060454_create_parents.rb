class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :name
      t.string :relation
      t.string :education
      t.string :profession
      t.string :dob
      t.string :income
      t.string :iqamaNumber
      t.string :iqamaExpiry
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :officePhone
      t.string :mobile
      t.string :email

      t.timestamps null: false
    end
  end
end
