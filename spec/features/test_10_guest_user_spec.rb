require 'rails_helper'

RSpec.describe "guest user can create cart" do
  scenario "they cannot checkout" do
    item = create(:item)
    visit items_path

    click_on "Add to Cart"
    click_link "View Cart"

    visit cart_path

    expect(page).to have_content("#{item.title}")

    click_button "Checkout"

    expect(page).to have_content("Login or Create Account to Checkout")
    expect(page).to_not have_content("Logout")
  end
end
