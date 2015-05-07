json.array!(@snapshots) do |snapshot|
  json.extract! snapshot, :id, :user_id, :nwea_math, :nwea_reading, :math, :reading, :science, :social_studies
  json.url snapshot_url(snapshot, format: :json)
end
