class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    validates :content, presence: true
    
    paginates_per 50


  # relacion recursiva de retweet
    belongs_to :tweet, optional: true
    has_many :tweets, dependent: :destroy

    # def retweet_count
    #   Tweet.where(tweet_id: :self.id).count
    # end

    def retweets
      retweet_count = Tweet.group(:tweet_id).count
      retweet_count.each do |key, value|
          if self.id == key
              return value
          end
      end
    return 0
    end
  
    
    def original_tweet
      @original_tweet = Tweet.find(self.tweet_id)
    end
  end

