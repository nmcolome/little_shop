require 'rails_helper'

RSpec.describe "visitor can view all items" do
  scenario "they can see the page for all items" do
    item = create(:item, title: "Patagonia Women's Jacket")

    visit items_path  ### Do we want to have an index for all items or only through categories?? categories_item_path??

    expect(page).to have_content(item.title)

  end
end
