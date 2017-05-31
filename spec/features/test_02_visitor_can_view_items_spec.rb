require 'rails_helper'

RSpec.describe "visitor can view all items" do
  scenario "they can see the page for all items" do
    item = create(:item, title: "Patagonia Women's Jacket")
    item2 = create(:item, title: "Patagonia Men's Jacket")
    item3 = create(:item, title: "Patagonia Child's Snowpants")

    visit items_path  ### Do we want to have an index for all items or only through categories?? categories_item_path??

    expect(page).to have_content(item.title)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item3.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item2.price)
    expect(page).to have_content(item3.price)
    expect(page).to have_link("Add to Cart")

  end
end
