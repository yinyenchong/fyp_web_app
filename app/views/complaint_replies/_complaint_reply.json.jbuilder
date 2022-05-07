json.extract! complaint_reply, :id, :reply, :created_at, :updated_at
json.url complaint_reply_url(complaint_reply, format: :json)
