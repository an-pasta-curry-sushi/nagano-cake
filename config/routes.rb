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

    get "search"=>"items#search"
    get "sort"=>"items#sort"
  end

  scope module: :public do
    root :to => 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resource :customers, only: [] do
      get '/quit_check' => 'customers#quit_check', as: 'quit_check'
      patch '/withdraw' => 'customers#withdraw', as: 'withdraw'
      get '/my_page' => 'customers#show'
      patch '/my_page' => 'customers#update'
      get '/my_page/edit' => 'customers#edit'
    end
    get '/items/rank_index' => 'items#rank_index', as: 'items_ranks'
    resources :items, only: [:index, :show]

    get '/orders/thanks' => 'orders#thanks', as: 'thanks_order'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :deliveries, only: [:index, :edit, :update, :create, :destroy]
    resources :orders, only: [:index, :show, :new, :create]
    post '/orders/confirm' => 'orders#confirm', as: 'confirm_order'
    delete '/favorite/destroy_all' => 'favorites#destroy_all', as: 'favorites_destroy_all'
    resources :favorites, only: [:index, :create, :destroy]

    get "search"=>"items#search"
    get "sort"=>"items#sort"

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
