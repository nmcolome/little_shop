class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :order_items
  has_many :orders, through: :order_items

  enum status: ["active", "retired"]

  def category_list=(categories_string) #writing
    category_names = categories_string.split(",").collect{ |s| s.strip.downcase }.uniq
    new_or_found_categories = category_names.collect { |name| category.find_or_create_by(name: name) }
    self.categories = new_or_found_categories
  end

  def category_list #reading
    self.categories.collect do |category|
      category.name
    end.join(", ")
  end

  def cart_subtotal(order)
    self.get_quantity(order) * self.price
  end

  def get_quantity(order)
    order.order_items.find_by(item_id: self.id).quantity
  end
end
