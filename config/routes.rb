Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, param: :username
    resources :books
    post '/users/search', to: 'users#search_users'
    post '/books/search', to: 'books#search_books'
  end

  resource :session, path_names: {new: 'signup', create: 'signup'}, only: [:new, :create] 

  #user
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'
  get '/home', to: 'users#home'
  post '/home/search', to: 'users#search'
  get '/books', to: 'users#books'
  get '/book/:isbn/', to: 'users#book', as: 'book'
  get '/return/:id', to: 'users#return', as: 'return'
  get '/borrow/:id', to: 'users#borrow', as: 'borrow'


  

  

  #session
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  root 'sessions#login'


end
