class AddPriceAtPurchaseToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :price_at_purchase, :decimal
  end
end
