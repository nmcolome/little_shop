require 'rails_helper'

RSpec.describe "Authenticated user can see contents on show page" do
    scenario "user can log in and see contents" do
      user = create(:user)
      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button 'Login'

      within '.navbar' do
        expect(page).to have_content("Logged in as #{user.username}")
      end
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Hello, #{user.first_name} #{user.last_name}")
      expect(page).to have_content("#{user.email}")

      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")
  end
end
