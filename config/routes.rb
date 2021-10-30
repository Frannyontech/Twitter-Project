Rails.application.routes.draw do
  
  # get 'likes/create'
  # resources :likes
  # devise_for :users
  
  resources :tweets do
    resources :likes
    member do
      post 'retweet'
    end
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

  
end
