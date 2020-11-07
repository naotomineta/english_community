Rails.application.routes.draw do
  root to: 'rooms#index'

  resources :rooms, only: [:index] do
    collection do
      get 'search'
    end
  end
end
