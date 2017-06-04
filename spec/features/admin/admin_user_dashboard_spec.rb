require 'rails_helper'

RSpec.describe "When a user visits an administrator's dashboard" do
  it "as an administrator" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit items_path
    click_on "My Account"
    expect(page).to have_content "Admin Dashboard"
  end

  it "as a registered user" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path(user)
    expect(page).to have_content "The page you were looking for doesn't exist."
  end

  it "as an unregistered user" do
    guest = "guest"
    visit admin_dashboard_path(guest)
    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
