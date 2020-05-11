require 'rails_helper'

describe 'As an Admin' do
  scenario 'I can create a new tutorial' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "Title", with: "How to How to"
    fill_in "Description", with: "Teaches you how to make a how to"
    fill_in "Thumbnail", with: "https://img.youtube.com/vi/1OijD72t4XY/0.jpg"
    click_button "Save"
    tutorial = Tutorial.last

    expect(tutorial.id).to be_present
    expect(current_path).to eq(tutorial_path(tutorial.id))
  end
  scenario 'I cant create a new tutorial without filling in required fields' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in "Thumbnail", with: "https://img.youtube.com/vi/1OijD72t4XY/0.jpg"
    click_button "Save"
    tutorial = Tutorial.last

    expect(tutorial).to_not be_present
    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("Title can't be blank and Description can't be blank")
  end
end
