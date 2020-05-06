require 'rails_helper'

describe 'As a logged in user' do
  describe 'When I visit /dashboard' do
    it 'see a Github section with a list of 5 of my repositories if I have a token' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to have_content("Github")

      within ".repos" do
        expect(page).to have_content("Repos")
        expect(page).to have_link("monster_shop_2001")
        expect(page).to have_link("activerecord-obstacle-course")
        expect(page).to have_link("adopt_dont_shop_2001")
        expect(page).to have_link("adopt_dont_shop_paired")
        expect(page).to have_link("b2-mid-mod")
      end
    end
    it 'does not see a Github section if I do not have a token' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      expect(page).to_not have_content("Github")
    end
    it 'sees a section called followers and a list of that users followers' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      within '.followers' do
        expect(page).to have_content('Followers')
        expect(page).to have_link('alex-latham')
        expect(page).to have_link('javier-aguilar')
      end
    end
    it 'sees a section called followers and a list of the users followers' do
      user = create(:user, token: "token #{ENV['GITHUB_TOKEN']}")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path

      within '.following' do
        expect(page).to have_content('Following')
        expect(page).to have_content('javier-aguilar')
        expect(page).to have_content('itemniner')
      end
    end
  end
end
