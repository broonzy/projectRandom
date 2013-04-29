class AddOrderIdToCartLineItem < ActiveRecord::Migration
  def change
    add_column :cart_line_items, :order_id, :integer
  end
end
