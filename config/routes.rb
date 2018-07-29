Rails.application.routes.draw do
  get 'contacts/new'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users,
             :controllers =>{:registrations => "registrations"}
  resources :users, only: [:show]  #sign_upなどはdeviseの機能を利用 この行がdevise_forより上だとnewやdestroyよりshowが優先される
  resources :mylists
  resources :products
  resources :contacts, only: [:new, :create]
  resources :reviews
  get 'users/show'
  
  #resources :products do
    #resources :reviews
  #end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  match '/about',     to: 'static_pages#about',    via: 'get'
  match '/faq',       to: 'static_pages#faq',      via: 'get'
  #match '/contact',   to: 'static_pages#contact',  via: 'get'
  
end
