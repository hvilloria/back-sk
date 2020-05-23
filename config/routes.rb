Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :categories, only: %i[index create update]
    resources :products, only: [:update, :create] do
      resources :variants, only: [:update], shallow: true
    end
    resources :orders, only: %i[index create update]
    resources :sells, only: %i[index]
  end
end
