require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it 'can see a list of all bookmarked segments' do
    tutorial= create(:tutorial)
    tutorial2= create(:tutorial)
    tutorial3= create(:tutorial)

    video = create(:video, tutorial_id: tutorial.id)
    video2 = create(:video, tutorial_id: tutorial2.id)
    video3 = create(:video, tutorial_id: tutorial3.id)
    video4 = create(:video, tutorial_id: tutorial2.id)
    
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)
    click_on 'Bookmark'

    visit tutorial_path(tutorial2)
    click_on 'Bookmark'
    click_on video4.title 
    click_on 'Bookmark'

    visit tutorial_path(tutorial3)
    click_on 'Bookmark'

    visit dashboard_path

    within('.bookmarked') do
      expect(page).to have_link(video.title)
      expect(page).to have_link(video2.title)
      expect(page).to have_link(video3.title)
      expect(page).to have_link(video4.title)
    end
    
    within("#tutorial-#{tutorial.id}") do
      expect(page).to have_link(video.title)
      expect(page).to_not have_link(video2.title)
    end

    within("#tutorial-#{tutorial2.id}") do
      expect(page).to have_link(video2.title)
      expect(page).to have_link(video4.title)
      expect(page).to_not have_link(video3.title)
    end
  end

  it 'user must be logged-in to bookmark a video' do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial.id)

    click_on "Bookmark"

    expect(current_path).to eq(login_path)
    expect(page).to have_content('User must login to bookmark videos.')
    expect(UserVideo.all).to be_empty
  end
end
