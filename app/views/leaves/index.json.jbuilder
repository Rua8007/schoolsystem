json.array!(@leaves) do |leave|
  json.extract! leave, :id, :reason, :description, :employee_id, :leave_from, :leave_to
  json.url leave_url(leave, format: :json)
end
