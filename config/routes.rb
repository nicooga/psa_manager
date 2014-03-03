PsaManager::Application.routes.draw do
  resources :users do
    scope module: :users do
      resources :contacts do
        scope module: :contacts do
          resources :installations, only: :index
          resources :activities, only: [:index, :create]
        end
      end # under module Users::Contacts

      resources :activities do
        member do
          put :complete
          put :fail
        end
      end

      resources :cold_lists do
        resources :calls, module: :cold_lists
      end

      resources :kits
      resources :societies

    end # under module Users
  end

  resources :products

  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  namespace :sessions, as: '' do
    get :new, as: :login
    get :destroy, as: :logout
  end
end
