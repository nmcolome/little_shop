require 'rails_helper'

RSpec.describe "item creation" do
  context "as admin" do
    it "they fill out new item form" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/items/new" #new_admin_item_path
      fill_in "Title", with: "Mat"
      fill_in "Description", with: "Black"
      fill_in "Price", with: "50"
      fill_in "Categories", with: "Yoga, Gear"
      # select "Yoga", from: "categories"
      # fill_in "Status", with: "active"

      click_on "Create Item"
      item = Item.find_by(title: "Mat")

#SHOULD I REDIRECT TO A SHOW PAGE OR UPDATE THE INDEX PAGE??
      expect(current_path).to eq(admin_item_path(item)) #"/admin/items/#{item.id}"
      expect(page).to have_content("Mat")
      expect(page).to have_content("Black")
      expect(page).to have_content("$50.00")
      expect(page).to have_content("Active")  #by default
      expect(page).to have_link('Edit Item')
    end
  end

  context "as registered user" do
    it "they can't see the page" do
      user = User.create(email: "hpotter@email.com"
                        username: "hpotter",
                        password: "password",
                        role: 0)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "user/items/new" #new_user_item_path

      expect(page).to_not have_content("Create Item")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do

      visit "user/items/new" #new_user_item_path

      expect(page).to_not have_content("Create Item")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
