class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def total
    items.reduce(0) do |total, item|
      total += item.cart_subtotal(self)
    end
  end
end
