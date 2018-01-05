Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, param: :username
    resources :books
    resources :library_records
    post '/users/search', to: 'users#search_users'
    post '/books/search', to: 'books#search_books'
  end

  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:create, :new, :edit, :show, :update]
  resource :home, only: [:new, :show]
  resources :books, param: :isbn, only: [:index, :show]
  resources :library_records, only: [:show, :destroy]

  root 'sessions#new'

end
