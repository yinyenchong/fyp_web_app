Rails.application.routes.draw do
  
  
  #resources
  resources :complaints do
    #patch :update_completed_status, on: :member
    resources :complaint_replies
   
  end
  
  resources :complaint do
    patch :update_completed_status, on: :member
  end
  
  
  
  resources :roles
  devise_for :users, :path_prefix => 'd', :controllers => { registrations: 'users/registrations' }
  resources :users
  
  #link_to "Update Completed Status", update_completed_status_path(complaint), method: :patch
  
  
  #get page links
  get 'static_pages/home'
  get 'static_pages/help'
  
  get 'complaints/new', to: 'complaints#new', as: 'newcomplaint'
  
  # list of all users
  get 'users',          to: 'users#index',  as: :all_users

  # single user
  get 'users/:id',      to: 'users#show',    as: :single_user
  
  
  
  #get 'users/:id/edit', to: 'users#edit',    as: :edit_user
  
  
  
  #match '/users',   to: 'users#index',   via: 'get'
  #match '/users/:id',     to: 'users#show',       via: 'get'
  

  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
