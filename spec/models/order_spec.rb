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

  it "can count how many items are in an order" do
    item = create(:item, price: 3)
    item2 = create(:item, price: 4)
    user = create(:user)
    order1 = create(:order, user_id: user.id)
    OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1, price_at_purchase: 3.00)
    OrderItem.create(item_id: item2.id, order_id: order1.id, quantity: 2, price_at_purchase: 4.00)

    expect(order1.item_count).to eq 3
  end

  it "can find the order date" do
    order1 = create(:order)

    expect(order1.order_date).to eq order1.created_at.to_date
  end

  it "can find the order time" do
    order1 = create(:order)

    expect(order1.order_time).to eq order1.created_at.strftime("%I:%M%p")
  end

  it "has access to items" do
    order1 = create(:order)

    expect(order1).to respond_to(:items)
  end

  it "can count orders by status" do
    create(:order, status: 0)
    create(:order, status: 0)
    create(:order, status: 1)
    create(:order, status: 1)
    create(:order, status: 1)
    create(:order, status: 2)
    create(:order, status: 3)
    create(:order, status: 3)

    expect(Order.orders_only("Ordered")).to eq 2
    expect(Order.orders_only("Paid")).to eq 3
    expect(Order.orders_only("Cancelled")).to eq 1
    expect(Order.orders_only("Completed")).to eq 2
  end
end
