Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  get '/register', to: 'bands#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  post '/send_request/:id', to: 'relationships#create', :as => "send_request"
  get '/accept_request/:id', to: 'relationships#accept_request', :as => "accept_request"

  get '/tags/:tag_name', to: 'tags#show', :as => "tag"

  get '/search', to: 'bands#search'

  resources :bands, only: [:show, :create] do
    resources :relationships, only: [:index]
  end

end
