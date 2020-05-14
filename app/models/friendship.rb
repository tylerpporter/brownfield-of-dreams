class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  class << self
    def create_reciprocal(user_id, friend_id)
      user = Friendship.create(user_id: user_id, friend_id: friend_id)
      friend = Friendship.create(user_id: friend_id, friend_id: user_id)
    end

    def destroy_reciprocal(user_id, friend_id)
      Friendship.find_by(user_id: user_id, friend_id: friend_id).destroy
      Friendship.find_by(user_id: friend_id, friend_id: user_id).destroy
    end
  end
end
