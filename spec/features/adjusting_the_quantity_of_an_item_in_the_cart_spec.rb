require 'rails_helper'

RSpec.describe "visitor can visit the cart" do
  scenario "they can increase the quantity of an item" do
    category = create(:category_with_items, items_count: 1)
    item1 = category.items.first

    visit category_path(category)

    click_on("Add to Cart")

    click_on("View Cart")
    expect(current_path).to eq("/carts")
    expect(page).to have_content("Quantity: 1") ## Look at amazon, they don't start with a set quantity, user selects from a dropdown then adds that number of items when they click on Add to Cart
    click_on "+"
    expect(current_path).to eq("/carts")  # By Selecting a different quantity, it shouldn't cause a page refresh
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("Subtotal: $200.00")
    expect(page).to have_content("Total: $200.00")
  end

  scenario "they can decrease the quantity of an item" do
    category = create(:category_with_items, items_count: 1)
    item1 = category.items.first

    visit category_path(category)

    click_on("Add to Cart")  ### Is this how we want to select 2 items
    click_on("Add to Cart")

    click_on("View Cart")
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 2")
    select "1", :from => "Qty:"
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Subtotal: #{item1.price}")
    expect(page).to have_content("Total: #{item1.price}")
  end
end
