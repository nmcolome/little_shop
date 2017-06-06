require 'rails_helper'

RSpec.describe "items view" do
  context "as admin" do
    it "they see all items" do
      admin = create(:user, role: 1)
      item1, item2 = create_list(:item, 2)
      item3 = create(:item, status: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)
      click_on "View All Items"

      expect(current_path).to eq(items_path) #"/admin/items"
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item3.price)
      expect(page).to have_content(item3.status)
      expect(page).to have_content(item2.status)
      expect(page).to have_content(item2.price)
      expect(page).to have_link('Edit Item')
    end
  end
end
