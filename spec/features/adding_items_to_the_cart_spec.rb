require 'rails_helper'

RSpec.describe "visitor can add items and remove from the cart" do
  # scenario "they can click a link to add item to cart" do
  #   category = create(:category_with_items, items_count: 1)
  #   item1 = category.items.first
  #   category2 = create(:category_with_items, items_count: 1)
  #   item2 = category2.items.first
  #
  #   visit category_path(category)
  #
  #   expect(page).to have_content(item1.title)
  #   expect(page).to have_link("Add to Cart")
  #
  #   click_on("Add to Cart")
  #   expect(page).to have_content("You now have 1 #{item1.title}.")
  #   expect(current_path).to eq(category_path(category))
  #
  #   click_on("Add to Cart")
  #   expect(page).to have_content("You now have 2 #{item1.title}s.")
  #
  #   visit category_path(category2)
  #
  #   click_on("Add to Cart")
  #
  #   expect(current_path).to eq(category_path(category2))
  #   expect(page).to have_content("You now have 1 #{item2.title}.")
  #
  #   click_on("View Cart")
  #
  #   expect(current_path).to eq("/carts")
  #   # expect(page).to have_css("img[src=\"#{item1.image}\"]")
  #   expect(page).to have_content(item1.title)
  #   expect(page).to have_content(item1.description)
  #   expect(page).to have_content(item1.price)
  #   expect(page).to have_content(item2.title)
  #   expect(page).to have_content(item2.description)
  #   expect(page).to have_content(item2.price)
  #   expect(page).to have_content("Quantity: 2")
  #   expect(page).to have_content("Subtotal: $200.00")
  #   # expect(page).to have_content(item2.order_items.quantity)
  #   expect(page).to have_content("Total: $300.00")
  # end
  #
  # scenario "visitor starts with an item and removes" do
  #   category = create(:category_with_items, items_count: 1)
  #   item1 = category.items.first
  #
  #   visit category_path(category)
  #
  #   expect(page).to have_content(item1.title)
  #   expect(page).to have_link("Add to Cart")
  #
  #   click_on("Add to Cart")
  #
  #   click_on("View Cart")
  #
  #   expect(current_path).to eq("/carts")
  #
  #   click_on("Remove")
  #
  #   expect(current_path).to eq("/carts")
  #   expect(page).to have_content("Successfully removed #{item1.title} from your cart.")
  #   expect(page).to have_link(item1.title, item_path(item1))
  #   expect(page).to_not have_css('h3', item1.title)
  #
  # end
end
