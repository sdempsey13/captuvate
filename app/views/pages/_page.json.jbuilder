json.extract! page, :id, :user_id, :url, :created_at, :updated_at
json.url page_url(page, format: :json)
