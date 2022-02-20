json.extract! short_url, :url, :short_code, :visits
json.short_url redirect_url(short_code: short_url.short_code)
