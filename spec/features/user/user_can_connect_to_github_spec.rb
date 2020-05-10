require 'rails_helper'

describe 'As a user' , :vcr do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end
  xscenario 'I can connect to Github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_button "Connect to Github"
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '12345',
      token: ENV['GITHUB_TOKEN']
      })
    expect(user.uid).to eq('12345')
  end
end
