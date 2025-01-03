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
        resources :users, only: [:show, :update] do
          patch :avatar, on: :member
        end

        resources :projects

        resources :uploads, only: [] do
          get :presigned_url, on: :collection
        end
      end
    end

    namespace :web do
      get "/quequeo/content",             to: "quequeo#content"
      get "/about_me/content",            to: "about_me#content"
      get "/work_experience/content",     to: "work_experience#content"
    end
  end
end
