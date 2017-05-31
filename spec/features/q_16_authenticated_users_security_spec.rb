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
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    visit admin_path(:current_user)
    expect(page).to_not have_content "Admin Dashboard"
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "cannot make themselves an admin" do
    ### I think this could be tested by them just not having access to the admin dashboard...
    # I'm not really sure how else to test it?
    # Is there a way to test if a user has access to a database?
  end
end
