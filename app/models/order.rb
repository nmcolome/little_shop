class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: ["Ordered", "Paid", "Cancelled", "Completed"]

  def total
    OrderItem.where(order_id: self.id).sum("price_at_purchase * quantity")
    # self.order_items.sum("price_at_purchase * quantity")
    # items.reduce(0) do |total, item|
    #   total += item.cart_subtotal(self)
    # end
  end
end
