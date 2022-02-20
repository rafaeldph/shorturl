Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'short_urls/index'
  resources :short_urls, only: [:show, :create], constraints: { format: 'json' }

  root to: 'short_urls#index'
end