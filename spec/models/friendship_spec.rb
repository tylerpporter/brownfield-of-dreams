require 'rails_helper'

describe Friendship do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friend}
  end
  describe 'class methods' do
    it 'create_reciprocal' do
      user1 = create(:user)
      user2 = create(:user)
      Friendship.create_reciprocal(user1.id, user2.id)
      friendship = Friendship.last

      expect(user1.friendships.size).to eq(1)
      expect(user2.friendships.size).to eq(1)
      expect(Friendship.all.size).to eq(2)
      expect(friendship.user_id).to eq(user2.id)
      expect(friendship.friend_id).to eq(user1.id)
    end
    it 'destroy_reciprocal' do
      user1 = create(:user)
      user2 = create(:user)
      Friendship.create_reciprocal(user1.id, user2.id)

      expect(Friendship.all.size).to eq(2)

      Friendship.destroy_reciprocal(user1.id, user2.id)

      expect(Friendship.all).to be_empty
    end
  end
end
