json.array!(@marks) do |mark|
  json.extract! mark, :id, :name, :marks, :passing_marks, :grade_id
  json.url mark_url(mark, format: :json)
end
