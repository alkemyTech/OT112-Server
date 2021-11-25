Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'auth/register', to: 'users#create'
      post 'auth/login', to: 'auth#create'
      # delete 'auth/logout', to: 'auth#destroy'
      get 'organization/public'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
