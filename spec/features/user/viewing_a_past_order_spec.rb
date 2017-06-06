require 'rails_helper'

RSpec.describe "User views a single order" do
  scenario "user can view an order that belongs to them" do
    binding.pry
      user = create(:user)
      order = Order.create(user_id: user.id)
      item_1 = create(:item)
      item_2 = create(:item)
      OrderItem.create(order_id: order.id, item_id: item_1.id, quantity: 3)
      OrderItem.create(order_id: order.id, item_id: item_2.id, quantity: 1)

      visit login_path

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"

      visit '/orders'

      click_on "View Order"

      expect(page).to have_content("#{item_1.title}")
      expect(page).to have_content("$#{item_1.price}")
      expect(page).to have_content("$#{order.order_items.first.quantity}")
      expect(page).to have_link(item_1.title, href: item_path(item_1))
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.total)
  end
end
