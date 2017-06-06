require 'rails_helper'

RSpec.describe "a user can access an item's information" do
  scenario "by clicking a link in the item index" do
    item = create(:item)
    item2 = create(:item)
    item3 = create(:item)

    visit items_path
    click_on item.title

    expect(current_path).to eq item_path(item)
    expect(page).to have_content item.title
    expect(page).to have_content item.description
  end
end
