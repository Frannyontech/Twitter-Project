Rails.application.routes.draw do
  
  get 'api/create', to:'api#create'
  get 'api/:first_date/:last_date', to:'api#by_date'
  post 'api/news', as: 'api_news'
  post 'api/create'
  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  
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
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tweets#index"

  # friends-followers
  post 'friend/:friend_id', to: 'friends#create', as: 'create'
  delete 'friend/:friend_id', to: 'friends#destroy', as: 'destroy'
end
