json.array!(@reports) do |report|
  json.extract! report, :id, :title, :writer_id, :language, :content
  json.url report_url(report, format: :json)
end
