require 'rails_helper'

RSpec.describe "orders view" do
  context "as admin" do
    it "views all orders" do
      admin = create(:user, role: 1)
      user = create(:user)
      item = create(:item)
      item2 = create(:item)
      item3 = create(:item)
      item4 = create(:item)
      item5 = create(:item)
      order1 = create(:order, user_id: user.id, status: 0)
      order2 = create(:order, user_id: user.id, status: "Paid")
      order3 = create(:order, user_id: user.id, status: "Cancelled")
      order4 = create(:order, user_id: user.id, status: "Completed")
      order5 = create(:order, user_id: user.id, status: "Ordered")
      OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1)
      OrderItem.create(item_id: item2.id, order_id: order2.id, quantity: 2)
      OrderItem.create(item_id: item3.id, order_id: order3.id, quantity: 1)
      OrderItem.create(item_id: item4.id, order_id: order4.id, quantity: 2)
      OrderItem.create(item_id: item5.id, order_id: order4.id, quantity: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_content("Order #{Order.all.last.id}")
      expect(page).to have_content("Ordered: 2")
      expect(page).to have_content("Paid: 1")
      expect(page).to have_content("Cancelled: 1")
      expect(page).to have_content("Completed: 1")
      expect(page).to have_link("Order #{Order.all.first.id}")
      expect(page).to have_select("order[status]", options: ["Ordered", "Paid", "Cancelled", "Completed"]) #this is the filter
    end

    it "paid orders can be cancelled" do
      admin = create(:user, role: 1)
      user = create(:user)
      order = create(:order, user_id: user.id, status: "Paid")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Cancelled", from: "order[status]"
      click_on "Update Status"
      order.reload
      expect(order.status).to eq('Cancelled')
    end

    it "ordered orders can be cancelled" do
      admin = create(:user, role: 1)
      user = create(:user)
      order = create(:order, user_id: user.id, status: "Ordered")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Cancelled", from: "order[status]"
      click_on "Update Status"
      order.reload
      expect(order.status).to eq('Cancelled')
    end

    it "ordered orders can be marked as paid" do
      admin = create(:user, role: 1)
      user = create(:user)
      order = create(:order, user_id: user.id, status: "Ordered")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Paid", from: "order[status]"
      click_on "Update Status"
      order.reload
      expect(order.status).to eq('Paid')
    end

    it "paid orders can be marked as completed" do
      admin = create(:user, role: 1)
      user = create(:user)
      order = create(:order, user_id: user.id, status: "Paid")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Completed", from: "order[status]"
      click_on "Update Status"
      order.reload
      expect(order.status).to eq('Completed')
    end
  end

  it "can filter orders to view only those with 'Ordered' status" do
    order1 = create(:order, status: 0)
    order2 = create(:order, status: 0)
    order3 = create(:order, status: 1)
    order4 = create(:order, status: 1)
    order5 = create(:order, status: 1)
    order6 = create(:order, status: 2)
    order7 = create(:order, status: 3)
    order8 = create(:order, status: 3)
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'
    expect(page).to have_content order1.id
    expect(page).to have_content order3.id
    expect(page).to have_content order6.id
    expect(page).to have_content order7.id

    click_link "Ordered"
    expect(page).to have_content order1.id
    expect(page).to_not have_content order3.id
    expect(page).to_not have_content order6.id
    expect(page).to_not have_content order7.id
  end

  it "can filter orders to view only those with 'Paid' status" do
    order1 = create(:order, status: 0)
    order2 = create(:order, status: 0)
    order3 = create(:order, status: 1)
    order4 = create(:order, status: 1)
    order5 = create(:order, status: 1)
    order6 = create(:order, status: 2)
    order7 = create(:order, status: 3)
    order8 = create(:order, status: 3)
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'
    expect(page).to have_content order1.id
    expect(page).to have_content order3.id
    expect(page).to have_content order6.id
    expect(page).to have_content order7.id

    click_link "Paid"
    expect(page).to have_content order3.id
    expect(page).to_not have_content order1.id
    expect(page).to_not have_content order6.id
    expect(page).to_not have_content order7.id
  end

  it "can filter orders to view only those with 'Cancelled' status" do
    order1 = create(:order, status: 0)
    order2 = create(:order, status: 0)
    order3 = create(:order, status: 1)
    order4 = create(:order, status: 1)
    order5 = create(:order, status: 1)
    order6 = create(:order, status: 2)
    order7 = create(:order, status: 3)
    order8 = create(:order, status: 3)
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'
    expect(page).to have_content order1.id
    expect(page).to have_content order3.id
    expect(page).to have_content order6.id
    expect(page).to have_content order7.id

    click_link "Cancelled"
    expect(page).to have_content order6.id
    expect(page).to_not have_content order1.id
    expect(page).to_not have_content order3.id
    expect(page).to_not have_content order7.id
  end

  it "can filter orders to view only those with 'Completed' status" do
    order1 = create(:order, status: 0)
    order2 = create(:order, status: 0)
    order3 = create(:order, status: 1)
    order4 = create(:order, status: 1)
    order5 = create(:order, status: 1)
    order6 = create(:order, status: 2)
    order7 = create(:order, status: 3)
    order8 = create(:order, status: 3)
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'
    expect(page).to have_content order1.id
    expect(page).to have_content order3.id
    expect(page).to have_content order6.id
    expect(page).to have_content order7.id

    click_link "Completed"
    expect(page).to have_content order7.id
    expect(page).to_not have_content order1.id
    expect(page).to_not have_content order3.id
    expect(page).to_not have_content order6.id
  end

end
