Rails.application.routes.draw do
  if Rails.env.development? || Rails.env.test?
    get "up" => "rails/health#show", as: :rails_health_check
  end

  namespace :api do
    namespace :web do
      get "/quequeo/content",             to: "quequeo#content"
      get "/about_me/content",            to: "about_me#content"
      get "/work_experience/content",     to: "work_experience#content"
    end

    namespace :resume do
      namespace :v1 do
        post "/register", to: "auth#register"
        post "/login", to: "auth#login"

        resources :users, only: [:show, :update] do
          patch :avatar, on: :member
        end


        resources :sections, only: [:create, :update, :destroy]

        resources :resumes do
          get :styles, on: :collection
        end

        resources :suggestions, only: [:create]
      end
    end
  end
end
