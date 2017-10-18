Rails.application.routes.draw do
  root "topics#index"
  resources :users
  resources :topics

  resources :topics do
    resource :like
  end

  get "signup", to: "users#new", as: "signup"
  get "signin", to: "sessions#new", as: "signin"
  post "signin", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
