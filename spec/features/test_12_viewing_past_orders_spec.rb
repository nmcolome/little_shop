require 'rails_helper'

RSpec.describe "User can view past orders" do
  scenario "user views past orders" do
  user = create(:user_with_orders)
  order_1 = user.orders.first
  order_2 = user.orders.last

  visis login_path

  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Login"

  visit user_orders_path(user)

#Should we add total price to order table???
  expect(page).to have_content("Order #{order_1.id}")
  expect(page).to have_content("Order #{order_2.id}")
  end
end
