json.pagination do
    json.page @page
    json.limit @limit
    json.total @total
    json.last_page @last_page
end

json.short_urls do
    json.array! @short_urls, partial: "short_urls/short_url", as: :short_url
end
