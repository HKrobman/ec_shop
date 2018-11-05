Rails.application.routes.draw do
  get 'users/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  
  devise_for :users,
             :controllers =>{:registrations => "registrations"}
  
  resources :users, only: [:show]  #sign_upなどはdeviseの機能を利用
  
  resources :likes, only:[:create, :destroy]
  resources :mylists
  resources :contacts, only: [:new, :create]
  resources :carts
  
  resources :cart_items
  
  resources :orders do
    collection do
      post 'confirm'
      post 'pay'
      get 'accepted'
    end
  end
  
  resources :products 
  resources :reviews do
    collection do
      get 'edit'
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  match '/about',     to: 'static_pages#about',    via: 'get'
  match '/faq',       to: 'static_pages#faq',      via: 'get'
  
end
