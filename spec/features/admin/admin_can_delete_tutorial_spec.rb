require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end
  scenario 'and all of its associated videos should no longer exist' do
    admin = create(:admin)
    create_list(:tutorial, 2)
    tutorial = Tutorial.first
    video_params = { title: 'SNL', description: 'Funny', video_id: 'KLLU3LvK_Hc'}
    tutorial.videos.create(video_params)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)
    expect(tutorial.videos.size).to eq(1)
    expect(Video.all.size).to eq(1)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
    expect(Video.all).to be_empty
  end
end
