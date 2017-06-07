require 'rails_helper'

RSpec.describe "an admin can filter orders list by status" do
  scenario "to only see ordered items" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_content "Order #{order3.id}"
    expect(page).to have_content "Order #{order4.id}"

    click_link "View Ordered:"
save_and_open_page
    expect(page).to have_content "Order #{order1.id}"
    expect(page).to_not have_content "Order #{order2.id}"
    expect(page).to_not have_content "Order #{order3.id}"
    expect(page).to_not have_content "Order #{order4.id}"

    click_link "All Orders"

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_content "Order #{order3.id}"
    expect(page).to have_content "Order #{order4.id}"
  end

  scenario "to only see paid items" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_content "Order #{order3.id}"
    expect(page).to have_content "Order #{order4.id}"

    click_link "View Paid:"

    expect(page).to have_content "Order #{order2.id}"
    expect(page).to_not have_content "Order #{order1.id}"
    expect(page).to_not have_content "Order #{order3.id}"
    expect(page).to_not have_content "Order #{order4.id}"
  end

  scenario "to only see cancelled items" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_content "Order #{order3.id}"
    expect(page).to have_content "Order #{order4.id}"

    click_link "View Cancelled:"

    expect(page).to have_content "Order #{order3.id}"
    expect(page).to_not have_content "Order #{order1.id}"
    expect(page).to_not have_content "Order #{order2.id}"
    expect(page).to_not have_content "Order #{order4.id}"
  end

  scenario "to only see completed items" do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    order1 = create(:order_with_items, status: 0)
    order2 = create(:order_with_items, status: 1)
    order3 = create(:order_with_items, status: 2)
    order4 = create(:order_with_items, status: 3)

    visit admin_dashboard_path

    expect(page).to have_content "Order #{order1.id}"
    expect(page).to have_content "Order #{order2.id}"
    expect(page).to have_content "Order #{order3.id}"
    expect(page).to have_content "Order #{order4.id}"

    click_link "View Completed:"

    expect(page).to have_content "Order #{order4.id}"
    expect(page).to_not have_content "Order #{order1.id}"
    expect(page).to_not have_content "Order #{order2.id}"
    expect(page).to_not have_content "Order #{order3.id}"
  end
end
