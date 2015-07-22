json.array!(@fees) do |fee|
  json.extract! fee, :id, :student_id, :amount, :user_id, :month
  json.url fee_url(fee, format: :json)
end
