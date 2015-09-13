json.array!(@examcalenders) do |examcalender|
  json.extract! examcalender, :id, :bridge_id, :title, :description, :category, :starttime, :endtime
  json.url examcalender_url(examcalender, format: :json)
end
