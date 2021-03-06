Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Users
  post "login", to: "users#login"
  post "register", to: "users#create"

  # Algorithms
  post "algorithm/create", to: "algorithms#create"
  get "algorithms", to: "algorithms#show"

  #Report
  get "train_data/migraine", to: "reports#train_data_migraine"
  get "train_data/cervical_cancer", to: "reports#train_data_cervical_cancer"
  post "report/migraine", to: "reports#create_migraine"
  post "report/cervical_cancer", to: "reports#create_cervical_cancer"
end
