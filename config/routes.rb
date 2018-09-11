Rails.application.routes.draw do
  get 'contacts/new'
  get 'users/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users,
             :controllers =>{:registrations => "registrations"}
  
  resources :users, only: [:show]  #sign_upなどはdeviseの機能を利用
  
  
  
  resources :mylists
  resources :contacts, only: [:new, :create]
  
  post '/update_item' => 'carts#update_item'
  resources :carts
  
  resources :cart_items
  
  
  
  resources :products
  resources :reviews
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  match '/about',     to: 'static_pages#about',    via: 'get'
  match '/faq',       to: 'static_pages#faq',      via: 'get'
  #match '/contact',   to: 'static_pages#contact',  via: 'get'
  
end
