json.array!(@performances) do |performance|
  json.extract! performance, :id, :student_id, :bridge_id, :remark
  json.url performance_url(performance, format: :json)
end
