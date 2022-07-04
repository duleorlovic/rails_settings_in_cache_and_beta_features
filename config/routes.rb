Rails.application.routes.draw do
  get 'admin/settings_and_beta_features'
  resources :articles
  get 'pages/index'
  get "sign-in-development/:id", to: "pages#sign_in_development", as: :sign_in_development
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "admin/settings_and_beta_features"
  post "admin/update_settings_and_beta_features"

  # Defines the root path route ("/")
  root "pages#index"
end
