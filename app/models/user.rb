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

  def RT_count
    self.tweets.count {|tweet| !tweet.tweet_id.nil?}
  end
end