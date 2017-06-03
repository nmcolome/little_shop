require 'rails_helper'

RSpec.describe "guest user can create cart" do
  scenario "they cannot checkout" do
    category = create(:category_with_items, items_count: 1)
    item = category.items.first
    visit items_path

    click_on "Add to Cart"
    click_on "Add to Cart"
    click_on "View Cart"

    expect(page).to have_content("#{item.title}")
    expect(page).to have_content('2')
    expect(page).to have_content("Login or Create Account to Checkout")

    click_on "Login or Create Account to Checkout"
    click_link "Create Account"
    fill_in "user[first_name]", with: "zuzu"
    fill_in "user[last_name]", with: "Thomas"
    fill_in "Email", with: "meatball_lover@puppy.com"
    fill_in "user[username]", with: "zuzu_puppy"
    fill_in "Password", with: "meatball"
    fill_in "Address", with: "121 zuzu"
    fill_in "State", with: "CO"
    fill_in "City", with: "Zuzu"
    fill_in "Zipcode", with: "80120"
    click_button "Create Account"
    visit carts_path

    expect(page).to have_content("#{item.title}")
    expect(page).to have_content('2')
  end
end
