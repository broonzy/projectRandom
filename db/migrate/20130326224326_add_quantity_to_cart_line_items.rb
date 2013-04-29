class AddQuantityToCartLineItems < ActiveRecord::Migration
  def change
    add_column :cart_line_items, :quantity, :integer, default: 1
  end
end
