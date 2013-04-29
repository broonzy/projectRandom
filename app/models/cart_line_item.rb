class CartLineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :shape
  belongs_to :cart
  attr_accessible :cart_id, :shape_id

  def total_price
    shape.price * quantity
  end

end
