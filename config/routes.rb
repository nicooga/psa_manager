PsaManager::Application.routes.draw do
  root to: 'activities#index'

  resources :activities
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
