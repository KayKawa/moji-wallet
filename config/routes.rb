Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations",
               omniauth_callbacks: "omniauth_callbacks"
             }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "homes#index"
  resource :wallet, only: [:show], path: "/:url" do
    resources :trades, only: %i[index create], path: "/moji"
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
