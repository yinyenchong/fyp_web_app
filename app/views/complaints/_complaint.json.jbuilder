json.extract! complaint, :id, :title, :body, :created_at, :updated_at
json.url complaint_url(complaint, format: :json)
