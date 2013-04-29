class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Cheque", "Credit card", "Purchase order" ]
  SIZES = [ "Small", "Medium", "Large" ]
  attr_accessible :address, :email, :name, :size, :pay_type
  has_many :cart_line_items, dependent: :destroy
  # ...
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  validates :size, inclusion: SIZES

  def add_cart_line_items_from_cart(cart)
    cart.cart_line_items.each do |item|
      item.cart_id = nil
      cart_line_items << item
    end
  end
end
