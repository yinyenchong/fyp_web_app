Rails.application.routes.draw do
  
  #resources
  resources :complaints
  devise_for :users
  
  
  
  #get page links
  get 'static_pages/home'
  get 'static_pages/help'
  
  get 'complaints/new', to: 'complaints#new', as: 'newcomplaint'
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
