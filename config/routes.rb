Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :categories, only: %i[index create update]
    resources :products, only: [:update]
    resources :orders, only: [:index]
  end
end
