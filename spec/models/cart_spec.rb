require 'rails_helper'

RSpec.describe Cart do
  describe "#total" do
    it "can calculate the total number of items it holds" do
      item = Item.create(title: "itemz", description: "greatest", price: 4, status: 0)
      item_2 = Item.create(title: "scuba", description: "worst", price: 3, status: 0)

      cart = Cart.new({item.id.to_s => 2, item_2.id.to_s => 3})
      expect(cart.total).to eq(17)
    end
  end

  describe "#find_quantity_subtotal" do
    it "finds quantity and subtotal" do
      item = Item.create(title: "itemz", description: "greatest", price: 4, status: 0)
      item_2 = Item.create(title: "scuba", description: "worst", price: 3, status: 0)

      cart = Cart.new({item.id.to_s => 2, item_2.id.to_s => 3})

      cart.find_quantity_subtotal

      expect(cart.contents.values).to eq([2, 3])
    end
  end

  describe "#increase_quantity" do
    it "increases content quantity" do
      item = Item.create(title: "itemz", description: "greatest", price: 4, status: 0)
      item_2 = Item.create(title: "scuba", description: "worst", price: 3, status: 0)

      cart = Cart.new({item.id.to_s => 2, item_2.id.to_s => 3})
      expect(cart.increase_quantity(item.id)).to eq(3)
      expect(cart.total).to eq 21
    end
  end

  describe "#decrease_quantity" do
    it "decreases content quantity" do
      item = Item.create(title: "itemz", description: "greatest", price: 4, status: 0)
      item_2 = Item.create(title: "scuba", description: "worst", price: 3, status: 0)

      cart = Cart.new({item.id.to_s => 2, item_2.id.to_s => 3})
      expect(cart.decrease_quantity(item.id)).to eq(1)
      expect(cart.total).to eq 13
    end
  end
end
