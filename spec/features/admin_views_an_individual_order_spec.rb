require 'rails_helper'

RSpec.describe "visit individual order" do
  context "as admin" do
    it "views details of an order" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      user = create(:user)
      category = Category.create(name: "Yoga")
      
      order1 = create(:order)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      click_on "Order #{order1.id}"
      expect(current_path).to eq(user_order_path(user, order1)) #verify path
      expect(page).to have_content("Date: #{order1.timestamp.date}") ##verify this
      expect(page).to have_content("Time: #{order1.timestamp.time}") ##verify this
      expect(page).to have_content("Purchaser: #{order1.user.full_name}")
      expect(page).to have_content("Address: #{order1.user.address}")
      expect(page).to have_content("Items")
      expect(page).to have_content("Quantity")
      expect(page).to have_content("Price")
      expect(page).to have_content("Subtotal")
      expect(page).to have_content("Status")
      expect(page).to have_content(order.items.first.title)
      expect(page).to have_content(order.order_items.quantity)
      expect(page).to have_content(order.items.first.price)
      expect(page).to have_content(order.order_items.subtotal) #or with AR?
      expect(page).to have_content(order.total) #or with AR?
      expect(page).to have_content(order.current_status)
    end
  end
end
