Rails.application.routes.draw do
  devise_for :users
  root 'projects#index'

  resources :home, only: :index
  resources :projects do
    collection do
      get :liked
      get :own
    end
  end
end
