require 'rails_helper'

RSpec.describe 'as a vistior' do
  describe 'when I register' do
    it 'has my account as deactive' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(user.status).to eq('inactive')
    end
  end
end