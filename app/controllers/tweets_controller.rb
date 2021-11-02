class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    if params[:q]
      @tweets = Tweet.where("content LIKE ?", "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
    else
      @tweets = Tweet.order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
    @user = current_user
    @users = User.all
    # @tweets = Tweet.all.order("created_at DESC").limit(50)
    
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.create(tweet_params)
    @user = current_user
    @tweet.user = @user
  

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  
  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def retweet
    
    original_tweet = Tweet.find(params[:tweet_id].to_i)
    @tweet = Tweet.create(
      content: original_tweet.content,
      user_id: original_tweet.user_id,
      retweet: current_user.id,
      tweet_id: original_tweet.id
    )
    if @tweet.save
      redirect_to root_path, notice: "Retweet was successfully created."
    end
  end 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end
end

