require 'rails_helper'

RSpec.describe "visitor can add items and remove from the cart" do
  scenario "they can click a link to add item to cart" do
    category = create(:category, name: "Surf")
    item1 = create(:item, title: "Wetsuit", category: category)

    visit category_path(category)

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
    category = create(:category, name: "Surf")
    item1 = create(:item, title: "Wetsuit", category: category)

    visit category_path(category)

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
    #(Test that the item is not in the cart)????? How do we test this is the content from line 44 is static? Won't it remain making it impossible for us to test expect(page).to_not have_content(item1.title)

  end
end
