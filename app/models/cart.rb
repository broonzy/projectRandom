class Cart < ActiveRecord::Base
  has_many :cart_line_items, dependent: :destroy

  def add_shape(shape_id)
    current_item = cart_line_items.find_by_shape_id(shape_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_line_items.build(shape_id: shape_id)
    end
    current_item
  end

  def total_price
    cart_line_items.to_a.sum { |item| item.total_price }
  end

end
