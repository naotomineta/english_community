Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'rooms#index'

  resources :users, only: [:show, :edit, :update] 
    member do
  resources :rooms, only: [:index, :new, :create, :show, :destroy] do
    resources :messages, only: [:new, :create]
    collection do
      get 'search'
    end
  end
  resources :memos, only: [:index, :new, :create, :edit, :update, :destroy]
end
