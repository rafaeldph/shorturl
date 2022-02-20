Rails.application.routes.draw do
  resources :short_urls, only: [:index]
  resources :short_urls, only: [:show, :create], constraints: { format: 'json' }

  get ':short_code', to: 'short_urls#redirect', as: :redirect

  root to: 'short_urls#index'
end