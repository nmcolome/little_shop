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
      save_and_open_page
      expect(page).to have_select("order[status]", options: ["Ordered", "Paid", "Cancelled", "Completed"]) #this is the filter
    end

    it "paid or ordered orders can be cancelled" do
      admin = create(:user, role: 1)
      order = create(:order, status: "paid")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Cancel", from: "order[status]"
      expect(order.status).to eq('cancelled')
    end
  #
  #   it "paid or ordered orders can be cancelled" do
  #     admin = create(:user, role: 1)
  #     order = create(:order, status: "ordered")
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #     visit "admin/dashboard" #new_admin_item_path
  #
  #     expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
  #     select "Cancel", from: "order[status]"
  #     expect(order.status).to eq('cancelled')
  #   end
  #
  #   it "ordered orders can be marked as paid" do
  #     admin = create(:user, role: 1)
  #     order = create(:order, status: "ordered")
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #     visit "admin/dashboard" #new_admin_item_path
  #
  #     expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
  #     select "Paid", from: "order[status]"
  #     expect(order.status).to eq('paid')
  #   end
  #
  #   it "paid orders can be marked as completed" do
  #     admin = create(:user, role: 1)
  #     order = create(:order, status: "paid")
  #
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  #
  #     visit "admin/dashboard" #new_admin_item_path
  #
  #     expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
  #     select "Completed", from: "order[status]"
  #     expect(order.status).to eq('completed')
  #   end
  end
end
