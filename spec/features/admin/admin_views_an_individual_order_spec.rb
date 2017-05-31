require 'rails_helper'

RSpec.describe "visit individual order" do
  context "as admin" do
    it "views details of an order" do
      admin = create(:user, role: 1)
      user = create(:user)
      order1 = create(:order_with_items)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path
      click_on "Order #{order1.id}"
      expect(current_path).to eq(user_order_path(user, order1))
      expect(page).to have_content("Date: #{order1.timestamp.date}") ##verify this
      expect(page).to have_content("Time: #{order1.timestamp.time}") ##verify this
      expect(page).to have_content("Purchaser: #{order1.user.first_name} #{order1.user.last_name}")
      expect(page).to have_content("Address: #{order1.user.address_line}, #{order1.user.city}, #{order1.user.state}, #{order1.user.zipcode}")
      expect(page).to have_css("th", "Items")
      expect(page).to have_css("th", "Quantity")
      expect(page).to have_css("th", "Price")
      expect(page).to have_css("th", "Subtotal")
      expect(page).to have_css("th", "Total")
      expect(page).to have_css("th", "Status")
      expect(page).to have_css("td", order.items.first.title)
      expect(page).to have_css("td", order.order_items.quantity)
      expect(page).to have_css("td", order.items.first.price)
      expect(page).to have_css("td", order.order_items.subtotal) #or with AR?
      expect(page).to have_css("td", order.total) #or with AR?
      expect(page).to have_css("td", order.current_status)
    end
  end
end
