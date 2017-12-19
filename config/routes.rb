Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :books
  
  get 'login', to: 'users#index'
  post 'login', to: 'users#login'
  get 'logout', to: 'users#logout'

  controller :admin do
    get 'admin/users', action: :users
    get 'admin/books', action: :books
    post 'admin/users/search', action: :search_users
    post 'admin/books/search', action: :search_books
  end

  root 'users#index'

end
