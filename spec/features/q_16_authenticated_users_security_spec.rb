require 'rails_helper'

RSpec.describe "An authenticated regular user" do
  before(:each) do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it "cannot see another user's private data" do
    user2 = create(:user)
    visit login_path

    fill_in "Username", with: user2.username
    fill_in "Password", with: user2.password
    click_button "Login"

    visit user_path(user)
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "cannot view the administrator screens or use admin functionality" do
    visit '/admin/dashboard'
    item = create(:item)

    expect(page).to_not have_content "Admin Dashboard"
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit admin_item_path(item)
    expect(page).to have_content "The page you were looking for doesn't exist."

    visit new_admin_item_path
    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
