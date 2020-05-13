require 'rails_helper'

describe 'As a user' , :vcr do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end
  scenario 'I can connect to Github' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '12345',
      credentials:{token: ENV['GITHUB_TOKEN']},
      info:{nickname: 'tylerpporter'}
      })
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path

    expect(user.uid).to eq(nil)

    click_button "Connect to Github"

    expect(user.uid).to eq('12345')
    expect(current_path).to eq(dashboard_path)
  end
end
