class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes

    paginates_per 50
end
