class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    validates :content, presence: true
    
    paginates_per 50

# like button
def liked?(user)
    self.likes.find_by(user_id: user.id).present?
  end
  # count Likes
  def like_count
    self.likes.empty? ? 0 : self.likes.count
  end
  
  # users likes
  def self.liker_users(tweet_obj, users_array)
        
    #obtain an array with user_id relationed with the tweet
    likes_collection = tweet_obj.likes
    users_id_collection = Array.new
    
    likes_collection.each do |like|
      users_id_collection << like.user_id
    end
  
    #obtain an array with users objects relationed with the tweet and likes
    likerUsers = Array.new
    users_array.each do |user|
      users_id_collection.each do |id|
        likerUsers << user if user.id == id 
      end
    end
  
    return likerUsers
  end
  
  #RT count
  def retweets_count
    retweets = Tweet.all.count {|tweet| tweet.tweet_id == self.id}
  end
  
  #users who retweet count
  def retwitted_from
    tweets = Tweet.all.where(tweet_id: self.id).distinct.count(:user_rt)
  end

end
