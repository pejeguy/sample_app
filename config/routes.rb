Rails.application.routes.draw do
  root 'pages#home'
  
  get '/contact',   to: 'pages#contact'
  get '/about',   to: 'pages#about'
  get '/help',   to: 'pages#help'
  get 'users/new', to: 'users#new', as: '/signup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
