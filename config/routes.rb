PsaManager::Application.routes.draw do
  resources :contacts

  root to: 'sessions#new'
  # Omniauth callback
  get '/auth/:provider/callback', to: 'sessions#create'
  namespace :sessions, as: '' do
    get :new, as: :login
    get :destroy, as: :logout
  end
end
