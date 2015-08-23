json.array!(@curriculums) do |curriculum|
  json.extract! curriculum, :id, :grade_id, :subject_id, :studentname
  json.url curriculum_url(curriculum, format: :json)
end
