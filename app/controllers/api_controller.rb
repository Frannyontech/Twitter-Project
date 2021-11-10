class ApiController < ApplicationController
  before_action :verify_authenticity_token, only:[:create]
  skip_before_action :verify_authenticity_token, on: [:create]
  
  def news
    
    tweets = Tweet.all.order(created_at: :desc).limit(50)
    @tweet_response = []
    tweets.each do |tweet|
      h = {
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        likes_count: tweet.likes.count,
        retweets_count: tweet.retweet_count,
      }
      @tweet_response.push h
    end
    render json: @tweet_response
  end

  def by_date
    @first_date = params[:first_date]
    @last_date = params[:last_date]
    @tweets_by_date = Tweet.where('created_at BETWEEN ? AND ?', @first_date, @last_date)
    @tweet_response = []
    @tweets_by_date.each do |tweet|
      @tweet_response << {
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        likes_count: tweet.likes.count,
        retweets_count: tweet.retweets_count,
      }
    end
    render json: @tweet_response
  end

  def create
     
    if @user.nil?
      render json: {status: 'ERROR', message: "Error en autenticación. Email o password incorrecto."}, status: :unauthorized
    else
      tweet = Tweet.new(tweet_params)
      tweet.user = @user
    
      if tweet.save
        render json: {status: 'SUCCESS', message: "Tweet creado", data:tweet}, status: :ok
      else
        render json: {status: 'ERROR', message: "Tweet no pudo ser creado", data:tweet.errors}, status: :unprocessable_entity
      end
      
    end
  end

end
