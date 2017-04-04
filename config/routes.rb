Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  get '/register', to: 'bands#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/send_request/:id', to: 'relationships#send_request', :as => "send_request"
  get '/accept_request/:id', to: 'relationships#accept_request', :as => "accept_request"

  resources :bands, only: [:show, :create]

end
