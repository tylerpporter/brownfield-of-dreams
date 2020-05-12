class FriendshipsController < ApplicationController
  def create
    Friendship.create_reciprocal(current_user.id, params[:friend_id])
  end
end
