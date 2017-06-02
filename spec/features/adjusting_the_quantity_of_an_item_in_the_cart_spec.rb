require 'rails_helper'

RSpec.describe "visitor can visit the cart" do
  # scenario "they can increase the quantity of an item" do
  #   category = create(:category_with_items, items_count: 1)
  #   item1 = category.items.first
  #
  #   visit category_path(category)
  #
  #   click_on("Add to Cart")
  #
  #   click_on("View Cart")
  #   expect(current_path).to eq("/carts")
  #   expect(page).to have_content("Quantity: 1") ## Look at amazon, they don't start with a set quantity, user selects from a dropdown then adds that number of items when they click on Add to Cart
  #   click_on "+"
  #   expect(current_path).to eq("/carts")  # By Selecting a different quantity, it shouldn't cause a page refresh
  #   expect(page).to have_content("Quantity: 2")
  #   expect(page).to have_content("Subtotal: $200.00")
  #   expect(page).to have_content("Total: $200.00")
  # end
  #
  # scenario "they can decrease the quantity of an item" do
  #   category = create(:category_with_items, items_count: 1)
  #   item1 = category.items.first
  #
  #   visit category_path(category)
  #
  #   click_on("Add to Cart")
  #   click_on("Add to Cart")
  #
  #   click_on("View Cart")
  #   expect(current_path).to eq("/carts")
  #   expect(page).to have_content("Quantity: 2")
  #   click_on "-"
  #   expect(current_path).to eq("/carts")
  #   expect(page).to have_content("Quantity: 1")
  #   expect(page).to have_content("Subtotal: $100.00")
  #   expect(page).to have_content("Total: $100.00")
  # end
  #
  # scenario "when they decrease the quantity of an item to 0 it is removed from their cart" do
  #   category = create(:category_with_items, items_count: 1)
  #   item1 = category.items.first
  #
  #   visit category_path(category)
  #
  #   click_on("Add to Cart")
  #
  #   click_on("View Cart")
  #   expect(current_path).to eq("/carts")
  #   expect(page).to have_content("Quantity: 1")
  #   expect(page).to have_content item1.title
  #
  #   click_on "-"
  #   expect(page).to_not have_button "-"
  #   expect(page).to_not have_content item1.description
  #   expect(current_path).to eq("/carts")
  #
  #   expect(page).to have_content("Total: $0.00")
  # end
end
