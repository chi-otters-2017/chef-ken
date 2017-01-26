Rails.application.routes.draw do
  get 'measures/new'

  root 'categories#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: "users#new"
  post 'signup', to: "users#create"
  get 'profile', to: "users#show"


  resources :categories do
    resources :recipes, except: [:index, :show]
  end


  resources :recipes, only: [:show] do
    resources :measures, only: [:new, :create]
  end
end
