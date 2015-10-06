json.array!(@feebreakdowns) do |feebreakdown|
  json.extract! feebreakdown, :id, :grade_id, :title, :amount
  json.url feebreakdown_url(feebreakdown, format: :json)
end
