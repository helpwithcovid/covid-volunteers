Rails.application.routes.draw do
  root 'projects#index'


  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/p/:page' => 'users/registrations#index', as: 'users_with_pagination'
    get 'users', to: 'users/registrations#index', as: 'volunteers'
    get 'users/:id', to: 'users/registrations#show', as: 'profile'
  end

  get '/projects/p/:page' => 'projects#index', as: 'projects_with_pagination'

  resources :projects do
    collection do
      get :volunteered
      get :own
    end

    member do
      post :toggle_volunteer
      get :volunteers
    end
  end

  resources :offers

  resources :admin do
    collection do
      post :delete_user
      post :toggle_highlight
    end

    resources :volunteer_groups
  end
end
