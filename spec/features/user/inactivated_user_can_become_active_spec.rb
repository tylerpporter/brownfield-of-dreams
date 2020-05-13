require 'rails_helper'

RSpec.describe 'as a unactivated user' do
  describe 'through a email' do
    it 'can activate the user' do
      activation_emails = ActionMailer::Base.deliveries
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
      
      expect(activation_emails.count).to eq(0)
      click_on'Create Account'
      user = User.last
      expect(activation_emails.count).to eq(1)
      expect(activation_emails[0].body.encoded).to match('http://localhost:3000/users/1/activate')
    end
  end
end