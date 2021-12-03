Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      get 'auth/me', to: 'auth#show'
      # delete 'auth/logout', to: 'auth#destroy'
      get 'organizations/:id/public', to: 'organizations#public'
      resources :users, only: :update
      resources :announcements, only: [:update]
      post 'organizations/public', to: 'organizations#create'
    end
  end
end
