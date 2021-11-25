Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post 'auth/register', to: 'users#create'
      # post 'auth/login', to: 'auth#create'
      # delete 'auth/logout', to: 'auth#destroy'
=======
      resources :users
      post 'auth/login', to: 'auth#create'
      delete 'auth/logout', to: 'auth#destroy', as: 'logout'
>>>>>>> OT112-24: Add user resources routes only to show and destroy action
    end
  end
=======
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
end
