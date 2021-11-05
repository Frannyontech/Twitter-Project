class ApiController < ApplicationController
  before_action :verify_authenticity_token, only:[:create]
  skip_before_action :verify_authenticity_token, on: [:create]
  http_basic_authenticate_with name: "frang@example.com", password: "1234567", except: [:news, :by_date]

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
    data = JSON.parse(request.body.read)["content"]
    user_email = JSON.parse(request.body.read)["user"]
    @user = User.find_by(email: user_email)
    @tweet = Tweet.create(content: data, user_id: @user.id, parent_tweet: nil, content_retweet: nil)

    if @tweet.save
      render json: @tweet, status: :ok
    else
      render json: "Error en creacion, del tweet", status: :internal_server_error
    end
  end
end
