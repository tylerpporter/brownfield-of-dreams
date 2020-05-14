require 'rails_helper'

describe 'As a registered user', :vcr do
  scenario 'I can send an email invite to a valid Github handle that has an email address' do
    user = create(:user, token: "#{ENV['GITHUB_TOKEN']}", uid: 58486125, username: 'itemniner')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    click_link 'Send an Invite'

    expect(current_path).to eq(invite_path)

    fill_in :username, with: 'tylerpporter'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully sent invite!")
  end
  scenario 'I get an error message if I try to send an invite to an invalid Github handle or a handle that doesnt have an email address' do
    user = create(:user, token: "#{ENV['GITHUB_TOKEN']}", uid: 58486125, username: 'tylerpporter')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_link 'Send an Invite'
    fill_in :username, with: 'itemniner'
    click_on "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
