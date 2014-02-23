PsaManager::Application.routes.draw do
  root to: 'activities#index'

  resources :users do
    scope module: :users do
      resources :contacts do
        scope module: :contacts do
          resources :installations, only: :index
          resources :activities, only: [:index, :create]
        end
      end

      resources :activities do
        member do
          put :complete
          put :fail
        end
      end

      resources :kits
    end
  end

  resources :products

  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  namespace :sessions, as: '' do
    get :new, as: :login
    get :destroy, as: :logout
  end
end
