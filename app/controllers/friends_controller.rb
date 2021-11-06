class FriendsController < ApplicationController
  before_action :find_user
  
  # POST /friends or /friends.json
  def create
    current_user.friends.create(
        friend_id: @user.id
    )
    redirect_to root_path
end

def destroy
    if already_follow?
        @friendship.destroy_all
        redirect_to root_path
    end
end
  
private
  def find_user
    @user = User.find(current_user.id)
  end
  
  def find_friend
    @friendship = current_user.friends.where(friend_id: @user.id)
  end

  def already_follow?
    @user = User.find(params[:user_id])
    Friend.where(
        user_id: current_user.id,
        friend_id: @user.id
    ).exists?
  end
end
