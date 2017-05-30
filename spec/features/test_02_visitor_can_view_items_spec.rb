require 'rails_helper'

RSpec.describe "visitor can view all items" do
  scenario "they can see the page for all items" do
    item = create(:item)

    visit items_path

    expect(page).to have_content(item.title)

  end
end
