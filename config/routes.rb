Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, param: :username
    resources :books
    post '/users/search', to: 'users#search_users'
    post '/books/search', to: 'books#search_books'
  end

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  post '/profile/edit', to: 'users#update'

  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#login'
  get 'logout', to: 'sessions#logout'




end
