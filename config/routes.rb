Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  controller :sessions do
    get :login, action: :index
    post :login, action: :login
    get :logout, action: :logout
  end

  controller :dashboard do
    get :dashboard, action: :index
    get 'dashboard/new_user', action: :new_user
    get 'dashboard/list_users', action: :list_users
    get 'dashboard/search_box', action: :search_box
    post 'dashboard/search_user', action: :search_user
  end

  root 'sessions#index'
end
