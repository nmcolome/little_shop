class Cart
  attr_accessor :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def total_count
    contents.values.sum
  end

  def update_quantity(item_id)
    contents[item_id.to_s] = (contents[item_id.to_s] || 0) + 1
  end
end