class FriendshipsController < ApplicationController
  def create
    Friendship.create_reciprocal(current_user.id, params[:friend_id])
    # require "pry"; binding.pry
    redirect_to dashboard_path
  end
end
