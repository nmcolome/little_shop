require 'rails_helper'

RSpec.describe "items view" do
  context "as admin" do
    it "they see all items" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      item1, item2 = create_list(:item, 2)
      item3 = create(:item, status: 1)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "/admin/dashboard"
      click_on "View All Items"

      expect(current_path).to eq(admin_items_path) #"/admin/items"
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item3.price)
      expect(page).to have_content(item3.image)
      expect(page).to have_content(item3.status)
      expect(page).to have_content(item2.status)
      expect(page).to have_content(item2.price)
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

      visit "/admin/dashboard"

      expect(page).to_not have_content("View All Items")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do

      visit "/admin/dashboard"

      expect(page).to_not have_content("View All Items")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
