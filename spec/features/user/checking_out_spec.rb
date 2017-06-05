require 'rails_helper'

RSpec.describe "A registered user can checkout items in their cart" do
  scenario "as a visitor I'm required to login" do
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    item4 = create(:item)

    visit item_path(item1)
    click_on 'Add to Cart'

    visit item_path(item2)
    click_on 'Add to Cart'

    visit item_path(item3)
    click_on 'Add to Cart'

    visit item_path(item4)
    click_on 'Add to Cart'

    click_on 'View Cart'
    click_on "Login or Create Account to Checkout"

    expect(current_path).to eq login_path
  end

  scenario "as a registered user" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)
    item4 = create(:item)

    visit item_path(item1)
    click_on 'Add to Cart'

    visit item_path(item2)
    click_on 'Add to Cart'

    visit item_path(item3)
    click_on 'Add to Cart'

    visit item_path(item4)
    click_on 'Add to Cart'
    click_on 'View Cart'
    click_on 'Checkout'

    expect(current_path).to eq '/orders'
    expect(page).to have_content "Order was successfully placed"
    expect(page).to have_css('td', item1.title)
    # expect(page).to have_css('td', item.image)
    expect(page).to have_css('td', item1.price)
  end
end
