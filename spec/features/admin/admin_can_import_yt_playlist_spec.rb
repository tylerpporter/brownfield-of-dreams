require 'rails_helper'
require 'webmock/rspec'

describe 'As an Admin' do
  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  describe 'When I visit /admin/tutorials/new', :vcr do
    it 'can import a youtube playlist for a new tutorial' do

      visit new_admin_tutorial_path
      click_link "Import YouTube Playlist"

      expect(current_path).to eq('/admin/import/new')

      fill_in 'Title', with: 'Another How-To'
      fill_in 'Description', with: "Just another how-to tutorial."
      fill_in 'Thumbnail', with: "https://www.healthline.com/hlcmsresource/images/Image-Galleries/Onychauxis/thumb-732x549-thumbnail.jpg"
      fill_in 'Playlist', with: "PL795aDbK_A8F5VWD4otZOXutge7rEugKC"
      click_button 'Create'

      tutorial = Tutorial.last

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Successfully created tutorial. View it here.")

      click_link "View it here"

      expect(current_path).to eq(tutorial_path(tutorial.id))
      expect(tutorial.videos.sample.tutorial_id).to_not be_nil
      expect(tutorial.videos.sample.tutorial_id).to eq(tutorial.id)
      expect(page).to have_link(tutorial.videos.sample.title)
      expect(tutorial.videos.size).to eq(57)
    end
  end
end
