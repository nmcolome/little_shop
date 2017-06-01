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
end
