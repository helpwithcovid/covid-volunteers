Rails.application.routes.draw do
  root 'projects#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :projects do
    collection do
      get :liked
      get :own
    end
  end
end
