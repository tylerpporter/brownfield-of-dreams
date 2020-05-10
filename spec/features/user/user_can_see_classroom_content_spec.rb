require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'on the index page' do
    it 'can see classroom videos' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      tutorial = create(:tutorial, classroom: true)
      tutorial2 = create(:tutorial)

      visit '/'

      expect(page).to have_content(tutorial.title)
      expect(page).to have_content(tutorial2.title)
    end

    it 'can not see classroom videos if not logged in' do
      tutorial = create(:tutorial, classroom: true)
      tutorial2 = create(:tutorial)

      visit '/'

      expect(page).to_not have_content(tutorial.title)
      expect(page).to have_content(tutorial2.title)
    end
  end
end