require 'rails_helper'

RSpec.describe "item creation" do
  context "as admin" do
    it "they fill out new item form" do
      admin = create(:user, role: 1)
      create_list(:category, 2)

      visit login_path
      fill_in "user[username]", with: admin.username
      fill_in "user[password]", with: admin.password
      click_on 'Login'
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)
      click_on "Add new item"

      expect(current_path).to eq new_admin_item_path #new_admin_item_path
      fill_in "Title", with: "Mat"
      fill_in "Description", with: "Black"
      fill_in "Price", with: "50"
      fill_in "Category list", with: "#{Category.all.first.name}, #{Category.all.last.name}"
      select "Active", from: "Status"

      click_on "Create Item"
      item = Item.find_by(title: "Mat")

      expect(current_path).to eq(admin_item_path(item)) #"admin/items/#{item.id}"
      expect(page).to have_content("Mat")
      expect(page).to have_content("Black")
      expect(page).to have_content("$50.00")
      expect(page).to have_content("Active")  #by default
      expect(page).to have_link('Edit Item')
    end
  end

  context "as registered user" do
    it "they can't see the page" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "admin/items/new"

      expect(page).to_not have_content("Create Item")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do

      visit "admin/items/new"

      expect(page).to_not have_content("Create Item")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
