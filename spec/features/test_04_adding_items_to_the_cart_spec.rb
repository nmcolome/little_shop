require 'rails_helper'

RSpec.describe "visitor can add items and remove from the cart" do
  scenario "they can click a link to add item to cart" do
    category1 = create(:category)
    item1 = category1.items.first ###?????
    item2 = category1.items.last  ###????

    visit category_path(category1)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")

    click_on("View Cart")

    expect(current_path).to eq("/cart")
    expect(page).to have_css('img')
    expect(page).to have_content(item1.title)
    expect(page).to have_content(item1.description)
    expect(page).to have_content(item1.price)
    expect(page).to have_content("Total: #{item.price}")
  end

  scenario "visitor starts with an item and removes" do
    category1 = create(:category)
    item1 = category1.items.first ###?????
    item2 = category1.items.last  ###????

    visit category_path(category1)

    expect(page).to have_content(item1.title)
    expect(page).to have_link("Add to Cart")

    click_on("Add to Cart")

    click_on("View Cart")

    expect(current_path).to eq("/cart")

    click_on("Remove")

    expect(current_path).to eq("/cart")
    expect(page).to have_css("green") ####????
    expect(page).to have_content("Successfully removed #{item1.title} from your cart.")
    expect(page).to have_link(item_path(item1))
    #(Test that the item is not in the cart)?????
  end
end
