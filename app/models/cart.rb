class Cart
  attr_accessor :contents, :items

  def initialize(contents)
    @contents = contents || {}
    # @items = {}
  end

  def find_quantity_subtotal
    items = {}
    contents.each do |k,v|
      items[Item.find(k)] = {:quantity => v, :subtotal => Item.find(k).price * v}
    end
    items
  end

  def remove(item_id)
    contents.delete(item_id.to_s)
  end

  def total
    items = self.find_quantity_subtotal
    total = 0
    items.values.each do |item|
      total += item[:subtotal]
    end
    total
    # contents.values.sum
  end

  def increase_quantity(item_id)
    contents[item_id.to_s] = (contents[item_id.to_s] || 0) + 1
  end

  def decrease_quantity(item_id)
    if contents[item_id.to_s] == 0
      self.remove(item_id)
    else
      contents[item_id.to_s] = contents[item_id.to_s] - 1
    end
  end
end
