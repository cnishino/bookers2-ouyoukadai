Rails.application.routes.draw do
  get 'groups/new'
  get 'groups/index'
  get 'groups/show'
  get 'groups/create'
  get 'groups/edit'
  get 'groups/destroy'
  resources :chats, only: [:show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "/home/about"=>"homes#about", as: "about"
  get "/search" => "searches#search", as: "search"
  post "/search" => "searches#search_data", as: "search_data"

  resources :groups, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  	get "daily_posts" => "users#daily_posts"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end