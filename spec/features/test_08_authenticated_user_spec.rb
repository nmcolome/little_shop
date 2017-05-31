require 'rails_helper'

RSpec.describe "Authenticated user can log in" do
  scenario "user can log in and see profile" do
    user = create(:user)
    visit root_path

    click_link "Login"

    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    within '.navbar' do
      expect(page).to have_content("Logged in as #{user.username}")
    end
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content("Hello, #{user.name}")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")
  end

  scenario "user can not use bad credentials to log in" do
    user = create(:user)

    visit login_path

    fill_in "Username", with: "ThisIsNotMyName"
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content("Login to your account.")
  end
end
