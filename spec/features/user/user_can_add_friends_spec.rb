require 'rails_helper'

describe 'As a registered user', :vcr do
  scenario 'I can add a follower or following as a friend if they are a registered user' do
    user1 = create(:user, token: "#{ENV['GITHUB_TOKEN']}", uid: 58486125)
    user2 = create(:user, token: "#{ENV['GITHUB_TOKEN']}", uid: 49219371)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
    visit dashboard_path

    within '.followers' do
      click_button 'Add as Friend'
    end

    user1.reload

    expect(user1.friends).to eq([user2])
    expect(user2.friends).to eq([user1])
    expect(Friendship.all.size).to eq(2)
  
    # within '.friends' do
    #   expect(page).to have_content(user2.first_name)
    # end
  end
end
