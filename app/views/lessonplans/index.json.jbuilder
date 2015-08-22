json.array!(@lessonplans) do |lessonplan|
  json.extract! lessonplan, :id, :grade_id, :subject_id, :topic, :selection, :startdate, :enddate, :studentengage, :newvocabulary, :objectives
  json.url lessonplan_url(lessonplan, format: :json)
end
