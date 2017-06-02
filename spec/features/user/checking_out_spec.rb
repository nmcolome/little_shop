require 'rails_helper'

RSpec.describe "A registered user can checkout items in their cart" do
  scenario "as a visitor" do
    it "when they visit their cart page" do
      user = create(:user)
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      cart = create(:cart_with_items)

      visit '/cart'
      expect(page).to have_content "You must login to checkout"
      click_on "Login or Register to Checkout"

      expect(current_path).to eq login_path
    end
  end

  scenario "as a registered user" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cart = create(:cart_with_items)

    click_on "Checkout"

    expect(current_path).to eq '/orders'
    expect(page).to have_content "Order was successfully placed"
    expect(page).to have_css('td', item.name)
    expect(page).to have_css('td', item.image)
    expect(page).to have_css('td', item.price)
  end
end
