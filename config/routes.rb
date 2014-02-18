PsaManager::Application.routes.draw do
  root to: 'activities#index'

  resources :activities do
    member do
      put :complete
      put :fail
    end
  end
  resources :contacts
  resources :products
  resources :kits

  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  namespace :sessions, as: '' do
    get :new, as: :login
    get :destroy, as: :logout
  end
end
