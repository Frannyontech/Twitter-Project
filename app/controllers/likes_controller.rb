class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @tweet = Tweet.find(params[:tweet_id].to_i)
    @like = Like.new
    @like.user = current_user
    @like.tweet = @tweet

    respond_to do |format|
      if @like.save
        format.html { redirect_to root_path, notice: "Like Creado" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end

  end
end
