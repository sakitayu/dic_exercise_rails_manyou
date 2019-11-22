Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  #resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      resources :tasks
    end
  end


end
