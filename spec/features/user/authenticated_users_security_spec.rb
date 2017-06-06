require 'rails_helper'

RSpec.describe "An authenticated regular user" do
  before(:each) do
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it "cannot see another user's private data" do
    user = create(:user, first_name: "Natalia")
    user2 = create(:user, first_name: "Mogley")
    visit login_path

    fill_in "Username", with: user2.username
    fill_in "Password", with: user2.password
    click_button "Login"

    #visit dashboard_path(user)
    visit edit_user_path(user)

    expect(page).to_not have_content user.first_name
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "cannot view the administrator screens or use admin functionality" do
    user = create(:user, first_name: "Natalia")
    user2 = create(:user, first_name: "Mogley")
    item = create(:item)

    visit login_path
    fill_in "Username", with: user2.username
    fill_in "Password", with: user2.password
    click_button "Login"

    visit '/admin/dashboard'

    expect(page).to_not have_content "Admin Dashboard"
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit edit_admin_item_path(item)
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit new_admin_item_path
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "user cannot make themselves an admin" do
    user = create(:user, first_name: "Natalia")
    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    visit edit_user_path(user)

    expect(page).to_not have_content("Update Role")
    expect(page).to_not have_content("default")
  end
end
