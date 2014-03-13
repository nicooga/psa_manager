PsaManager::Application.routes.draw do
  root to: 'application#root'

  # Handle static resource-less pages
  get '/pages/:page_name', to: 'pages#page', as: :page

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
  controller :dashboard do
    get :dashboard, to: :index
  end

  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  namespace :sessions, as: '' do
    get :new, as: :login
    get :destroy, as: :logout
  end
end
