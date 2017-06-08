require 'rails_helper'

RSpec.describe "item creation" do
  context "as admin" do
    it "they can create a new category" do
      admin = create(:user, role: 1)
      create_list(:category, 2)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: admin.password

      click_on(class: 'login-submit')

      click_on "Add new item"

      expect(current_path).to eq new_admin_item_path 

      click_link "Create New Category"

      fill_in "Name", with: "Hovercraft"

      click_on "Create Category"
      expect(page).to have_content("Hovercraft")

    end
  end
end
