require 'rails_helper'

RSpec.describe "user edits an item" do
  context "as admin" do
    it "they can edit an item" do
      admin = create(:user, role: 1)
      item1 = create(:item)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)
      click_on "View All Items"
      expect(current_path).to eq(items_path)
      click_on "Edit Item"

      expect(current_path).to eq(edit_admin_item_path(item1)) #"/admin/items/:ITEM_ID/edit"
      fill_in "Description", with: "new description"
      click_on "Submit"

      expect(current_path).to eq(item_path(item1)) #"/admin/items/#{item.id}"
      expect(page).to have_content("new description")
    end
  end

  context "as registered user" do
    it "they can't see the page" do
      user = create(:user)
      item1 = create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit edit_admin_item_path(item1)

      expect(page).to_not have_content("Edit Item")
      expect(page).to_not have_content("Submit")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do
      item1 = create(:item)

      visit edit_admin_item_path(item1)

      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Submit")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
