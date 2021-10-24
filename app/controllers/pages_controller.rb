class PagesController < ApplicationController
  def index
    @tweets = Tweet.all.order("created_at DESC").limit(50)
  end
end
