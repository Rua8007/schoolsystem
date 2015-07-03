json.array!(@parents) do |parent|
  json.extract! parent, :id, :name, :relation, :education, :profession, :dob, :income, :iqamaNumber, :iqamaExpiry, :address1, :address2, :city, :country, :officePhone, :mobile, :email
  json.url parent_url(parent, format: :json)
end
