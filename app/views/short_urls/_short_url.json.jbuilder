json.extract! short_url, :id, :domain_id, :url, :short_code, :visits, :created_at, :updated_at
json.url short_url_url(short_url, format: :json)
