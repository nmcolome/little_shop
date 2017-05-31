require 'rails_helper'

RSpec.describe "visitor can visit the cart" do
  scenario "they can increase the quantity of an item" do
    category1 = create(:category)
    item1 = category1.items.first ###?????
    item2 = category1.items.last  ###????

    visit category_path(category1)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")

    click_on("View Cart")
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 1")
    ##Click an up arrow or some other button to increase quantity
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("Subtotal: #{item1.price * 2}")
    expect(page).to have_content("Total: #{item1.price * 2}")
  end

  scenario "they can increase the quantity of an item" do
    category1 = create(:category)
    item1 = category1.items.first ###?????
    item2 = category1.items.last  ###????

    visit category_path(category1)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")
    click_on("Add to Cart")

    click_on("View Cart")
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 2")
    ##Click an up arrow or some other button to increase quantity
    expect(current_path).to eq("/cart")
    expect(page).to have_content("Quantity: 1")
    expect(page).to have_content("Subtotal: #{item1.price}")
    expect(page).to have_content("Total: #{item1.price}")
  end
end
