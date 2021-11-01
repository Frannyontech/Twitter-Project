class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]
  skip_before_action :verify_authenticity_token  

  
  def create
    tweet = Tweet.find(params[:tweet_id])
        like = Like.create(user_id: current_user.id, tweet_id: tweet.id)
        
        if like.save
            redirect_to root_path, notice: "You just added a like!"
        end
  end
    
  def destroy
    if already_liked?
      @like.destroy
      redirect_to root_path
    end
  end
end

