Rails.application.routes.draw do
  
  #resources
  resources :complaints
  resources :users, :only =>[:show]
  devise_for :users, :path_prefix => 'd', :controllers => { registrations: 'users/registrations' }
  
  
  
  #get page links
  get 'static_pages/home'
  get 'static_pages/help'
  
  get 'complaints/new', to: 'complaints#new', as: 'newcomplaint'
  
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'
  

  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
