require 'rails_helper'

RSpec.describe "orders view" do
  context "as admin" do
    it "views all orders" do
      admin = create(:user, role: 1)
      create_list(:order, 5, status: "ordered")
      create_list(:order, 3, status: "paid")
      create_list(:order, 1, status: "cancelled")
      create_list(:order, 1, status: "completed")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path
      click_on "View All Orders"
      expect(current_path).to eq(admin_orders_path)

      expect(page).to have_content("Order #{Order.all.last.id}")
      expect(page).to have_content("Ordered: 5")
      expect(page).to have_content("Paid: 3")
      expect(page).to have_content("Cancelled: 1")
      expect(page).to have_content("Completed: 1")
      expect(page).to have_link("Order #{Order.all.first.id}")
      expect(page).to have_select("status", options: ["Ordered", "Paid", "Cancelled", "Completed"]) #this is the filter
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

    it "paid or ordered orders can be cancelled" do
      admin = create(:user, role: 1)
      order = create(:order, status: "ordered")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Cancel", from: "order[status]"
      expect(order.status).to eq('cancelled')
    end

    it "ordered orders can be marked as paid" do
      admin = create(:user, role: 1)
      order = create(:order, status: "ordered")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Paid", from: "order[status]"
      expect(order.status).to eq('paid')
    end

    it "paid orders can be marked as completed" do
      admin = create(:user, role: 1)
      order = create(:order, status: "paid")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path

      expect(page).to have_link("Order #{order.id}") ##change this - what are we naming each order?
      select "Completed", from: "order[status]"
      expect(order.status).to eq('completed')
    end
  end
end
