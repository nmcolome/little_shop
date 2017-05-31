require 'rails_helper'

RSpec.describe "Logged in user can log out" do
  scenario "user see the visitor options page" do
    user = create(:user)

    visit root_path

    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    click_button "Logout"

    expect(page).to have_link "Login", href: login_path
    expect(page).to_not have_content("Logout")
  end
end
