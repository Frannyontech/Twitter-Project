class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    validates :content, presence: true
    
    paginates_per 50

def retweet_ref
    Tweet.find(self.rt_ref)
end

end
