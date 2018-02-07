require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  describe 'register' do
    it 'registers new user' do
      user = build(:user)

      visit authentication_register_path
      fill_in :name, with: user.name
      fill_in :username, with: user.username
      fill_in :email, with: user.email
      fill_in :password, with: 'password_password'
      fill_in :password_repeat, with: 'password_password'
      click_on('Register')

      expect(page).to have_current_path(root_path)
    end
  end

  describe 'login' do
    it 'logins' do
      password = 'password_password'
      user = create(:user, password: password)

      visit authentication_login_path
      fill_in :username, with: user.username
      fill_in :password, with: password
      click_on('Login')

      expect(page).to have_current_path(root_path)
    end
  end
end
