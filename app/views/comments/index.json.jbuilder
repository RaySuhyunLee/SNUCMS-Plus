json.array!(@comments) do |comment|
  json.extract! comment, :id, :contents, :commenter, :issue_id
  json.url comment_url(comment, format: :json)
end
