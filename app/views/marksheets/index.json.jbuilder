json.array!(@marksheets) do |marksheet|
  json.extract! marksheet, :id, :exam_id, :bridge_id, :totalmarks, :obtainedmarks, :student_id
  json.url marksheet_url(marksheet, format: :json)
end
