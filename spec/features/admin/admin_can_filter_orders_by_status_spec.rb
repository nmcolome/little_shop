require 'rails_helper'

RSpec.describe "an admin can filter orders list by status" do
  scenario "when they are in their dashboard" do
    admin = create(:user, role: 1)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content order1.id
    expect(page).to have_content order2.id
    expect(page).to have_content order3.id
    expect(page).to have_content order4.id

    expect(page).to have_content "Filter by: "
    select "Ordered", from: "Status"
    click_on "Filter Orders"

    expect(page).to have_content order1.id
    expect(page).to_not have_content order2.id
    expect(page).to_not have_content order3.id
    expect(page).to_not have_content order4.id

    select "All", from: "Status"
    click_on "Filter Orders"

    expect(page).to have_content order1.id
    expect(page).to have_content order2.id
    expect(page).to have_content order3.id
    expect(page).to have_content order4.id
  end
end
