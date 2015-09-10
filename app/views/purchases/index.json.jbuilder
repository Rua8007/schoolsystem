json.array!(@purchases) do |purchase|
  json.extract! purchase, :id, :grade_id, :employee_id, :detail, :approve
  json.url purchase_url(purchase, format: :json)
end
