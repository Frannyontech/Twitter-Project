class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         paginates_per 50

  def to_s
    self.name
  end

  def like?(tweet_id)
    tweet = Tweet.find(tweet_id)
    likes = tweet.likes
    likes.each do |like|
      if like.user == self
        return true
      end
    end
    return false
  end
end