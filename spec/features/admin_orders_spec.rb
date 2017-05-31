require 'rails_helper'

RSpec.describe "orders view" do
  context "as admin" do
    it "views all orders" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      order1, order2, order3, order4 = create_list(:order, 4)

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      click_on "View All Orders"
      # expect(current_path).to eq(#somehting)

      expect(page).to have_content("Order #{Order.all.last.id}")
      expect(page).to have_content("Ordered: 5") #fix this
      expect(page).to have_content("Paid: 3")
      expect(page).to have_content("Cancelled: 1")
      expect(page).to have_content("Completed: 0")
      expect(page).to have_link(order1.id) ##change this - what are we naming each order?
      expect(page).to have_link('cancel') ##change this 'paid or ordered'
      expect(page).to have_link('mark as paid') ##change this - for 'ordered'
      expect(page).to have_link('mark as completed') ##change this - to only paid orders
      expect(page).to have_link('mark as completed')
    end

    it "paid or ordered orders can be cancelled" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      order = create(:order, status: 'paid')

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      expect(page).to have_link(order1.id) ##change this - what are we naming each order?
      expect(page).to have_link('cancel') ##change this 'paid or ordered'

      click_on "cancel"
      expect(order.status).to eq('cancelled')
    end

    it "paid or ordered orders can be cancelled" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      order = create(:order, status: 'paid')

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      expect(page).to have_link(order1.id) ##change this - what are we naming each order?
      expect(page).to have_link('cancel') ##change this 'paid or ordered'

      click_on "cancel"
      expect(order.status).to eq('cancelled')
    end

    it "ordered orders can be marked as paid" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      order = create(:order, status: 'ordered')

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      expect(page).to have_link(order1.id) ##change this - what are we naming each order?
      expect(page).to have_link('paid')

      click_on "paid"
      expect(order.status).to eq('paid')
    end

    it "paid orders can be marked as completed" do
      admin = User.create(email: "adumbledore@email.com"
                        username: "adumbledore",
                        password: "password",
                        role: 1)
      category = Category.create(name: "Yoga")
      order = create(:order, status: 'ordered')

      visit login_path
      fill_in "Username", with: admin.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "admin/dashboard" #new_admin_item_path
      expect(page).to have_link(order1.id) ##change this - what are we naming each order?
      expect(page).to have_link('completed')

      click_on "completed"
      expect(order.status).to eq('completed')
    end
  end

  context "as registered user" do
    it "they can't see the page" do
      user = User.create(email: "hpotter@email.com"
                        username: "hpotter",
                        password: "password",
                        role: 0)

      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "password"
      click_button "Sign In"

      visit "/admin/dashboard"

      expect(page).to_not have_content("View All Items")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context "as visitor" do
    it "they can't see the page" do

      visit "/admin/dashboard"

      expect(page).to_not have_content("View All Items")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
