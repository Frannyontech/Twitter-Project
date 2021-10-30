class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]
  skip_before_action :verify_authenticity_token  

  
def create
    tweet = Tweet.find(params[:id])
    like = Like.create(user_id: current_user.id, tweet_id: tweet.id)
        
    if like.save
        redirect_to root_path, notice: "You just added a like!"
    end
end
  
def destroy
  tweet = Tweet.find(params[:id])
  like = tweet.likes.find_by(user_id: current_user.id)
  like.destroy
  redirect_to root_path, notice: "You just added a dislike!"
end


  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def existing_like?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
  end

  def set_like
    @like = @tweet.likes.find(params[:id])
  end
end
