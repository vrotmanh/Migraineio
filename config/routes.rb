Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users
  post "login", to: "users#login"
  post "register", to: "users#create"

  # Algorithms
  post "algorithm/create", to: "algorithms#create"
  get "algorithms", to: "algorithms#show"
end
