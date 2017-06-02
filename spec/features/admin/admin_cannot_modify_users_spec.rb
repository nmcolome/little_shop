require 'rails_helper'

RSpec.describe "cannot edit another user" do
  context "as admin" do
    it "they edit their own profile" do
      admin = create(:user, role: 1)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


      visit "admin/dashboard" #I can see my profile
      expect(page).to have_content (admin.username)
      expect(page).to_not have_content (user.username)

      click_on "Edit my Profile"
      fill_in "Email", with: "dumble@yahoo.com"
      click_on "Update"

      expect(current_path).to eq admin_user_path(admin)
      expect(page).to have_content("dumble@yahoo.com")
      expect(page).to_not have_content(user.email)
    end

    xit "they cannot edit another user's profile" do
      admin = create(:user, role: 1)
      user = create(:user)

      visit edit_user_path(user)
      expect(page).to_not have_content(user.username)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
