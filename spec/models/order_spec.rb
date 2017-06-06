require 'rails_helper'

RSpec.describe Order do
  it "can find the total of all items in an order" do
    item = create(:item, price: 3)
    item2 = create(:item, price: 4)
    user = create(:user)
    order1 = create(:order, user_id: user.id)
    OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1, price_at_purchase: 3.00)
    OrderItem.create(item_id: item2.id, order_id: order1.id, quantity: 2, price_at_purchase: 4.00)

    expect(order1.total).to eq 11
  end

  it "has access to items" do
    item = create(:item, price: 3)
    item2 = create(:item, price: 4)
    user = create(:user)
    order1 = create(:order, user_id: user.id)
    OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1, price_at_purchase: 3.00)
    OrderItem.create(item_id: item2.id, order_id: order1.id, quantity: 2, price_at_purchase: 4.00)

    expect(order1).to respond_to(:items)
  end
end
