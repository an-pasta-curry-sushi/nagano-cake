Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root :to => 'homes#top'
    resources :items, only: [:index, :create, :new, :edit, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update] do
      get '/orders' => 'orders#index', as: 'orders'
    end
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end

  scope module: :public do
    root :to => 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resource :customers, only: [:edit, :update] do
      get '/quit_check' => 'customers#quit_check', as: 'quit_check'
      patch '/withdraw' => 'customers#withdraw', as: 'withdraw'
      get '/my_page' => 'customers#show'
    end
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :destroy, :update]
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]
    resources :orders, only: [:index, :show, :new, :create]
    post '/orders/confirm' => 'orders#confirm', as: 'confirm_order'
    get '/orders/thanks' => 'orders#thanks', as: 'thanks_order'

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
