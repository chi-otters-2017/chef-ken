Rails.application.routes.draw do
  root 'recipes#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: "users#new"
  post 'signup', to: "users#create"
  get 'profile', to: "users#show"
  # get 'friends', to: "users#index"
  resources :ingredients, only: [:new, :create]

  resources :categories do
    resources :recipes do
      resources :measures do
      end
    end
  end
  # root 'categories#index'
end
