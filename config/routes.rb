Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => 'sidekiq'
  root "topics#index"
  resources :users 
  resources :topics do
    collection do
      get :all
    end
    member do
      post :like
      delete :unlike
    end
  end
  

  get "signup", to: "users#new", as: "signup"
  get "signin", to: "sessions#new", as: "signin"
  post "signin", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  mount Simditor::Engine, at: "/"

  namespace :admin do
    resources :topics
  end
  root "topics#index"
end
