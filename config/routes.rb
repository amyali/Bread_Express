BreadExpress::Application.routes.draw do


  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  
  resources :items
  resources :item_prices
  # resources :order_items
  resources :users
  resources :sessions
  
  # Authentication routes
  get 'user/edit' => 'users#edit', as: :edit_current_user
  get 'signup' => 'customers#new', as: :signup
  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login


  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  
  # Set the root url
  root :to => 'home#home'  
  
  # Named routes
  get 'add_to_cart/:id' => 'items#add_to_cart', as: :add_cart
  get 'remove_item/:id' => 'items#remove_from_cart', as: :remove_cart
  get 'cart_list' => 'items#cart_list', as: :cart_list


  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
