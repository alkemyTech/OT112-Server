Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'announcements', to: 'announcements#show'
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      get 'auth/me', to: 'auth#show'
      # delete 'auth/logout', to: 'auth#destroy'
      resources :categories, only: %i[index show create destroy]
      get 'organizations/:id/public', to: 'organizations#public'
      post 'organizations/public', to: 'organizations#create'
      resources :users, only: :update
    end
  end
end
