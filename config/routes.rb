Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "/register", to: "auth#register"
      post "/login", to: "auth#login"

      namespace :customers do
        resources :users, only: [:index, :show, :create, :update, :destroy] do
          resources :projects, only: [:index, :show, :create, :update, :destroy]
        end
      end

      # admin@quequeo.com
      namespace :me do
        resources :projects

        resources :uploads, only: [] do
          get :presigned_url, on: :collection
        end
      end
    end
  end
end
