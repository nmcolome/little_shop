require 'rails_helper'

RSpec.describe "User views a single order" do
  scenario "user can view an order that belongs to them"do
    user = create(:user_with_orders)
      order = user.orders.first
      item_1 = create(:item)
      item_2 = create(:item)
      OrderItem.create!(order_id: order_1.id, item_id: item_1.id)
      OrderItem.create(order_id: order_1.id, item_id: item_2.id)

      visit login_path

      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Login'

      visit orders_path

      expect(page).to have_link('View order', href: order_path(order_1))

      click_link 'View order', href: order_path(order)

      expect(page).to have_content("#{item_1.title} $#{item_1.price}")
      expect(page).to have_content("#{item_2.title} $#{item_2.price}")
      expect(page).to have_link(item_1.title, href: item_path(item_1))
      expect(page).to have_link(item_2.title, href: item_path(item_2))
      expect(page).to have_content(order_1.status)
      expect(page).to have_content(order_2.status)
      expect(page).to have_content(order_1.price)
      expect(page).to have_content(order_2.price)
  end
end
