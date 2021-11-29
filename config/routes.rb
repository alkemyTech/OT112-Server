Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      # delete 'auth/logout', to: 'auth#destroy'
      get 'organizations/:id/public', to: 'organizations#public'
      resources :users, only: :update
    end
  end
end
