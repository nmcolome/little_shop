require 'rails_helper'

RSpec.describe "visitor can browse items by category" do
  scenario "they can see the page for a specific category" do
    category = create(:category, name: "Surf")
    item1 = create(:item, title: "Wetsuit", category: category)
    item2 = create(:item, title: "Cold Weather Wax", category: category)

    visit category_path(category)

    expect(page).to have_content(item1.title)
    expect(page).to have_content(item2.title)
  end
end
