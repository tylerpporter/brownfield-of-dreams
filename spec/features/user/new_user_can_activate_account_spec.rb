require 'rails_helper'

RSpec.describe 'as a vistior' do
  describe 'when I register' do
    it 'has my account as deactive' do     
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit register_path

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      user = User.last

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Logged in as #{user.first_name}")
      expect(page).to have_content('This account has not yet been activated. Please check your email')
      expect(user.status).to eq('inactive')
    end
  end
end