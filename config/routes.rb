Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :activities, only: %i[create update]
      resources :announcements, only: %i[show create update destroy]
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      get 'auth/me', to: 'auth#show'
      # delete 'auth/logout', to: 'auth#destroy'
      resources :categories, only: %i[index show create update destroy]
      resources :contacts, only: :create
      resources :members, only: %i[index create destroy]
      get 'organizations/:id/public', to: 'organizations#public'
      post 'organizations/public', to: 'organizations#create'
      resources :slides, only: %i[index show create update destroy]
      resources :testimonials, only: %i[create update destroy]
      resources :users, only: %i[index update destroy]
    end
  end
end
