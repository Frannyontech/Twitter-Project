class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]
  skip_before_action :verify_authenticity_token  

  def create
    if existing_like?
      flash[:notice] = 'ya le diste like'
    else
      @tweet.likes.create(user_id: current_user.id)
    end
    redirect_to root_path
  end
  
  def destroy
    if existing_like?
      @like.destroy
    else
      flash[:notice] = 'No se puede borrar, no tiene like'
    end
    redirect_to root_path
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
