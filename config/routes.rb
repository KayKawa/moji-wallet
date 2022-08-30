Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :wallets, only: [:index] do
    resources :transaction
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
