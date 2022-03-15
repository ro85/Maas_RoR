Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :contracts do
    resources :weekday_setups, only: [:edit, :update]
  end

  resources :monitoring_shifts do
    collection do
      get 'set'
      get 'calendar_confirmed'
    end
  end

  resources :user_monitoring_shifts do
    collection do
      patch 'mark_as_available'
    end
  end
end
