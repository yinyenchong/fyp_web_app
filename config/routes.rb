require 'sidekiq/web'


Rails.application.routes.draw do
  
  mount Sidekiq::Web => '/sidekiq'
  
  get 'users/show'
  
  # resources
  resources :complaints do
    #patch :update_completed_status, on: :member
    resources :complaint_replies
  end
  
  resources :complaint do
    patch :update_completed_status, on: :member
  end
  
  resources :rooms do
    resources :messages
  end
  
  resources :roles
  
  #devise_for :users, :path_prefix => 'd', :controllers => { registrations: 'users/registrations' }
  devise_for :users, :path_prefix => 'd'
  
  resources :users do
    member do
      get "show_profile"
    end
  end
  
  #get page links
  get 'static_pages/home'
  get 'static_pages/complaints_charts'
  
  get 'complaints/new', to: 'complaints#new', as: 'newcomplaint'
  
  # list of all users
  #get 'users',          to: 'users#index',  as: :all_users

  # single user
  #get 'users/:id',      to: 'users#show',    as: :single_user
  get 'user/:id', to: 'users#show', as: 'user_profile'

  
  #get 'users/:id/edit', to: 'users#edit',    as: :edit_user
  
  
  
  #match '/users',   to: 'users#index',   via: 'get'
  #match '/users/:id',     to: 'users#show',       via: 'get'
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
