require 'rails_helper'

RSpec.describe Item do
  context "it has attributes" do
    it "has all item attributes" do
      item = Item.create(title: "itemz",
      description: "greatest",
      price: 4,
      status: 0)

      expect(item.title).to eq "itemz"
      expect(item.description).to eq "greatest"
      expect(item.price).to eq 4
      expect(item.status).to eq "active"
    end

    it "must have a title" do
      item = Item.create(description: "greatest", price: 4, status: 0)

      expect(item).to be_invalid
    end

    it "must have a description" do
      item = Item.create(title: "itemz", price: 4, status: 0)

      expect(item).to be_invalid
    end

    it "must have a price" do
      item = Item.create(title: "itemz", description: "greatest", status: 0)

      expect(item).to be_invalid
    end

    it "default status is active" do
      item = Item.create(title: "itemz", description: "greatest")

      expect(item.status).to eq("active")
    end

    # it "must have an original title" do

    # end
  end
  context "has relationships" do
    it "with categories" do
      category = create(:category)
      item = category.items.create(title: "itemz",
                            description: "greatest",
                            price: 4,
                            status: 0)

    expect(item).to respond_to(:categories)
    end
  end
end
