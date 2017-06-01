class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :item_categories
  has_many :categories, through: :item_categories

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

  def subtotal
    Item.sum(:price)
  end
end
