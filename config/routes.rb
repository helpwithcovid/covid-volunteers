Rails.application.routes.draw do
  # Redirect www to non-www.
  if ENV['CANONICAL_HOST']
    constraints(host: Regexp.new("^(?!#{Regexp.escape(ENV['CANONICAL_HOST'])})")) do
      match '/(*path)' => redirect { |params, req| "https://#{ENV['CANONICAL_HOST']}/#{params[:path]}" },  via: [ :get, :post, :put, :delete ]
    end
  end

  root 'home#index'

  get '/about', to: 'home#about', as: 'about'

  get '/admin' => 'admin#index'
  get '/admin/edit' => 'admin#edit_site', as: 'edit_site'
  post '/admin/edit' => 'admin#edit_site'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/p/:page' => 'users/registrations#index', as: 'users_with_pagination'
    get 'users', to: 'users/registrations#index', as: 'volunteers'
    get 'users/:id', to: 'users/registrations#show', as: 'profile'
  end

  get '/projects/p/:page' => 'projects#index', as: 'projects_with_pagination'

  delete '/images/:resource_name/:resource_id', to: 'images#destroy'

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

  get '/office_hours/u/:id' => 'office_hours#index', as: 'office_hours_for_volunteer'
  resources :office_hours do
    member do
      post :apply
      post :accept
    end
  end

  resources :success_stories

  scope 'admin' do
    post :delete_user, to: 'admin#delete_user', as: 'delete_user'
    post :toggle_highlight, to: 'admin#toggle_highlight', as: 'toggle_project_highlight'

    resources :volunteer_groups, module: 'admin' do
      collection do
        post :generate_volunteers
        get :generate_volunteers
      end
    end
  end


  get '/:category_slug(/p/:page)', to: 'projects#index', action: :index


end
