require 'rails_helper'

RSpec.describe Category do

  it "has all required fields" do
    category = create(:category)

    expect(category).to be_valid
    expect(category.name).to eq(category.name)
  end

  it "requires a category name" do
    category = Category.create()

    expect(category).to be_invalid
  end

  it "requires unique category names" do
    category = Category.create(name: "synthetic")
    category2 = Category.create(name: "synthetic")

    expect(category2).to be_invalid
  end

  context "has relationships" do
    it "with items" do
      category = create(:category)
      item = category.items.create(title: "itemz",
                            description: "greatest",
                            price: 4,
                            status: 0)

    expect(category).to respond_to(:items)
    end
  end
end
