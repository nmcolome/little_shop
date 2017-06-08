require 'rails_helper'

RSpec.describe "Authenticated user can view past orders" do
    scenario "user can log in and view past orders" do
      user = create(:user_with_orders)
      order_1 = user.orders.first
      order_2 = user.orders.last

      visit root_path
      click_on 'Login'

      expect(current_path).to eq(login_path)

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button 'Login'

      click_on "View Past Orders"

      expect(current_path).to eq('/orders')

      expect(page).to have_content("Order #{order_1.id}")
      expect(page).to have_content("Order #{order_2.id}")
  end
end
