json.extract! domain, :id, :user_id, :url, :created_at, :updated_at
json.url page_url(domain, format: :json)
