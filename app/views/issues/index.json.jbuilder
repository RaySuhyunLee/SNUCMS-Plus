json.array!(@issues) do |issue|
  json.extract! issue, :id, :title, :contents
  json.url issue_url(issue, format: :json)
end
