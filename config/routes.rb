Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      delete 'auth/logout', to: 'auth#destroy', as: 'logout'
    end
  end
end
