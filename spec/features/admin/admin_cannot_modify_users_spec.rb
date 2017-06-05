require 'rails_helper'

RSpec.describe "cannot edit another user" do
  context "as admin" do
    it "they edit their own profile" do
      admin = create(:user, role: 1)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


      visit admin_dashboard_path(admin) #I can see my profile
      expect(page).to have_content (admin.username)
      expect(page).to_not have_content (user.username)

      click_on "Edit my Profile"
      fill_in "Email", with: "dumble@yahoo.com"
      click_on "Update"

      expect(current_path).to eq admin_user_path(admin)
      expect(page).to have_content("dumble@yahoo.com")
      expect(page).to_not have_content(user.email)
    end

    it "they can edit another user's role" do
      admin = create(:user, role: 1)
      user = create(:user, first_name: "Natalia")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_user_path(user)

      select "admin", from: "user[role]"
      click_on "Update Role"

      expect(current_path).to eq edit_user_path(user)
      expect(page).to have_content(user.username)
      expect(page).to have_content("admin")
      expect(page).to have_content "User role updated."
      user.reload
      expect(user.admin?).to be_truthy
    end
  end
end
