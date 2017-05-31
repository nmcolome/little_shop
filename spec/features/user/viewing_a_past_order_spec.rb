require 'rails_helper'

RSpec.describe "User views a single order" do
  scenario "user can view an order that belongs to them"do
    user = create(:user_with_orders)
      order_1 = user.orders.first
      item_1 = create(:item)
      item_2 = create(:item)
      OrderItem.create(order_id: order_1.id, item_id: item_1.id)

      visit login_path

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"

      visit user_orders_path(user)

      expect(page).to have_link("Order #{order_1.id}", href: user_order_path(user, order_1))

      click_link "Order #{order_1.id}", href: user_order_path(user, order_1)

#What should we write for old order specific item quantity???
# ActiveRecord or price in table for order_1.price???
      expect(page).to have_content("#{item_1.title} $#{item_1.price} $#{order.order_items.first.quantity}")
      expect(page).to have_link(item_1.title, href: item_path(item_1))
      expect(page).to have_content(order_1.status)
      expect(page).to have_content(order_1.price)
  end
end
