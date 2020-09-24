Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :categories, only: %i[index create update]
    resources :products, only: [:update, :create, :destroy] do
      resources :variants, only: [:update, :destroy], shallow: true
    end
    resources :orders, only: %i[index create update]
    resources :sells, only: %i[index]
    resources :promotions
  end
end
