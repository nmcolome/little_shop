require 'rails_helper'

RSpec.describe "an admin can filter orders list by status" do
  scenario "when they are in their dashboard" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content order1.id
    expect(page).to have_content order2.id
    expect(page).to have_content order3.id
    expect(page).to have_content order4.id

<<<<<<< HEAD
=======
    # expect(page).to have_content "Filter Orders By: "
>>>>>>> a56e50706e4815bde3e8ed2b83de50bbd8727793
    click_on "Ordered:"

    expect(page).to have_content order1.id
    expect(page).to_not have_content order2.id
    expect(page).to_not have_content order3.id
    expect(page).to_not have_content order4.id

    click_on "All Orders"

    expect(page).to have_content order1.id
    expect(page).to have_content order2.id
    expect(page).to have_content order3.id
    expect(page).to have_content order4.id
  end
end
