Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :announcements, only: %i[show create update destroy]
      get 'announcements', to: 'announcements#show'
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      get 'auth/me', to: 'auth#show'
      # delete 'auth/logout', to: 'auth#destroy'
      resources :categories, only: %i[index show create update destroy]
      resources :contacts, only: :create
      get 'organizations/:id/public', to: 'organizations#public'
      post 'organizations/public', to: 'organizations#create'
      resources :users, only: :update
      post 'activities', to: 'activities#create'
    end
  end
end
