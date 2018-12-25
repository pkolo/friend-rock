Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post   "/login"       => "sessions#create"
      delete "/logout"      => "sessions#destroy"

      resources :users, only: [:create] do
        member do
          get :verify_email
        end
      end

      resources :projects, only: [:create, :show]
    end
  end
end
