# require 'rails_helper'
#
# RSpec.describe "Authenticated user can edit profile" do
#     scenario "user can log in and edit profile contents" do
#       user = create(:user)
#       visit root_path
#
#       click_on 'Login'
#
#       expect(current_path).to eq(login_path)
#       fill_in "Username", with: user.username
#       fill_in "Password", with: user.password
#       click_button 'Login'
#
#       click_on "Edit Profile"
#
#       expect(current_path).to eq(edit_user_path(user))
#       fill_in "first_name", with: "Freya"
#       click_on "Update Profile"
#
#       expect(current_path).to eq('/dashboard')
#       expect(page).to have_content("Freya")
#   end
# end
