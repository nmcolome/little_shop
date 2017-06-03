class Order < ActiveRecord::Base
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def total
    items.sum(&:price)
  end
end
