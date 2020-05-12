require 'rails_helper'

describe Friendship do
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :friend}
  end
end
