Rails.application.routes.draw do
  get 'sessions/new'

  root 'pages#home'
  
  get '/contact', to: 'pages#contact'
  get '/about',   to: 'pages#about'
  get '/help',    to: 'pages#help'
  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
