class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ["Ordered", "Paid", "Cancelled", "Completed"]

  def total
    binding.pry
    items.reduce(0) do |total, item|
      total += item.cart_subtotal(self)
    end
  end
end
