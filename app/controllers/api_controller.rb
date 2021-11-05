class ApiController < ActionController::API
include ActionController::HttpAuthentication::Basic::ControllerMethods



  def news
    tweets = Tweet.all.order(created_at: :desc).limit(50)
    @tweet_response = []
    tweets.each do |tweet|
      h = {
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        likes_count: tweet.likes.likes_count,
        retweets_count: 

      }
      @tweet_response.push h
    end
    render json: @tweet_response
  end

  def tweets_range
    start_date = DateTime.parse(params[:fecha1]).beginning_of_day
    end_date = DateTime.parse(params[:fecha2]).end_of_day
    @tweets = Tweet.where("created_at >= ? AND created_at <= ?", start_date, end_date)
    if @tweets != nil
      render json: @tweets, status: :ok
    else
      render json: [], status: :no_content
    end
  end

end
