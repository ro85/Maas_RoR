Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :monitoring_shifts, only: [ :edit, :update ]
    end
  end

  resources :contracts do
    resources :weekday_setups, only: [:edit, :update]
  end

  resources :monitoring_shifts do 
    collection do
      patch 'tildar_todas'
    end
  end
end
