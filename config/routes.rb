Rails.application.routes.draw do
  
  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  
  resources :hashtag
  # get 'likes/create'
  # resources :likes
  # devise_for :users
  
  resources :tweets do
    resources :likes
      post 'retweet'
  end 

  resources :users do
    resources :tweets
  end
  
  devise_for :user, controllers: {
    registrations: 'users/registrations'
  }
  get 'tweets/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tweets#index"

  # friends-followers
  post 'user/:user_id', to: 'friends#create', as: 'friend_create'
  delete 'user/:user_id', to: 'friends#destroy', as: 'friend_destroy'
end
