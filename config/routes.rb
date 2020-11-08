Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'

  resources :users, only: [:edit, :update]
  resources :rooms, only: [:index, :new, :create, :show, :destroy] do
    collection do
      get 'search'
    end
  end
end
