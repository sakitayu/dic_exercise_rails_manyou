Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    collection do
      get 'errors'
    end
  end
  resources :tasks
  namespace :admin do
    resources :users
  end
  


end
