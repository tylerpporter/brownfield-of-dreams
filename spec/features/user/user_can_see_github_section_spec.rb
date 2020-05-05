require 'rails_helper'

describe 'As a logged in user' do
  describe 'When I visit /dashboard' do
    it 'see a Github section with a list of 5 of my repositories if I have a token' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Repos")
      expect(page).to have_css('.repos', count: 5)
    end
    it 'does not see a Github section if I do not have a token' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to_not have_content("Github")
      expect(page).to_not have_content("Repos")
    end
    it 'sees a section called followers and a list of the users followers' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Followers")
    end    
    it 'sees a section called followers and a list of the users followers' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_content("Followings")
    end
  end
end
