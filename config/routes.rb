Rails.application.routes.draw do
  get 'short_urls', to: 'short_urls#index'
  post 'short_urls', to: 'short_urls#create', constraints: { format: 'json' }
  get 'short_urls/domains', constraints: { format: 'json' }

  get ':short_code', to: 'short_urls#redirect', as: :redirect

  root to: 'short_urls#index'
end