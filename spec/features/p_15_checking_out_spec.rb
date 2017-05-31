require 'rails_helper'

RSpec.describe "A registered user can checkout items in their cart" do
  it "when they visit their cart page" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cart = create(:cart)

    visit '/cart'
    click_on "Login or Register to Checkout"
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Login'

    click_on "Cart"
    click_on "Checkout"

    expect(current_path).to eq '/orders'
    expect(page).to have_content "Order was successfully placed"
    expect(page).to have_css('tr', item.name)
    expect(page).to have_css('tr', item.image)
    expect(page).to have_css('tr', item.price)
  end
end
