require 'rails_helper'

RSpec.describe "As an admin" do
  it "when I log in, I can redirected to '/admin/dashboard'" do
    admin = create(:user, role: 1)

    visit login_path

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button 'Login'

    expect(current_path).to eq '/admin/dashboard'
    expect(page).to have_content "Admin Dashboard"
  end
end
