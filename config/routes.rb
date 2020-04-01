Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get "show", to: "users/registrations#show"
    get "logout", to: "users/registrations#logout"
  end
  root 'items#index'
  resources :cards, only: [:index, :new, :create, :destroy]
  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'purchase', to: 'items#purchase'
      post 'pay', to: 'items#pay'
      get 'done', to: 'items#done'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
