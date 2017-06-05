require 'rails_helper'

RSpec.describe "visitor can browse items by category" do
  scenario "they can see the page for a specific category" do
    category = create(:category_with_items, items_count: 2)
    item1 = category.items.first
    item2 = category.items.last

    visit category_path(category)


    expect(page).to have_content(category.name)
    expect(page).to have_content(item1.title)
    expect(page).to have_content(item2.title)
    expect(page).to have_content(item1.price)
    expect(page).to have_content(item2.price)
    expect(page).to have_link("Add to Cart")
  end
end
