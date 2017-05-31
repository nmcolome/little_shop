require 'rails_helper'

RSpec.describe "user edits an item" do
  context "as admin" do
    it "they can edit an item" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      item1 = create(:item)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "/admin/dashboard"
      click_on "View All Items"
      click_on "Edit"

      expect(current_path).to eq(edit_admin_items_path(item1)) #"/admin/items/:ITEM_ID/edit"
      fill_in "Description", with "new description"
      click_on "Submit"

      expect(current_path).to eq(admin_item_path(item1)) #"/admin/items/#{item.id}"
      expect(page).to have_content("new description")
    end
  end

  context "as registered user" do
    it "they can't see the page" do
      user = User.create(email: "hpotter@email.com"
                        username: "hpotter",
                        password: "password",
                        role: 0)
      category = Category.create(name: "Yoga")
      item1 = create(:item)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit edit_admin_items_path(item1)

      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Submit")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do
      category = Category.create(name: "Yoga")
      item1 = create(:item)

      visit edit_admin_items_path(item1)

      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Submit")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
