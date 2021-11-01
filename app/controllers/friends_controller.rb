class FriendsController < ApplicationController
  
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
    @user = User.find(params[:user_id])
  end 
  def find_friend
    @friendship = current_user.friends.where(friend_id: @user.id)
  end
end
