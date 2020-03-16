Rails.application.routes.draw do
  root 'projects#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :projects do
    collection do
      get :volunteered
      get :own
    end

    member do
      post :toggle_volunteer
    end
  end
end
