require 'rails_helper'

RSpec.describe "visitor can browse items by category" do
  scenario "they can see the page for a specific category" do
    category1 = create(:category)
    item1 = category1.items.first ###?????
    item2 = category1.items.last  ###????

    visit category_path(category1)

    expect(page).to have_content(item1.title)
    expect(page).to have_content(item2.title)
  end
end
