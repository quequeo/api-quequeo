Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "/register", to: "auth#register"
      post "/login", to: "auth#login"
    end
  end
end
