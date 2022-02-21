json.extract! short_url, :url, :short_code, :visits
json.short_url redirect_url(short_code: short_url.short_code)
json.alexa_rank short_url.domain.alexa_rank
