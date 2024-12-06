Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "/register", to: "auth#register"
      post "/login", to: "auth#login"
      get "/instance", to: "ec2#instance"

      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resources :projects, only: [:index, :show, :create, :update, :destroy]
        resources :profiles, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
end
