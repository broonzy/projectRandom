class CombineItemsInCart < ActiveRecord::Migration

  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each shape in the cart
      sums = cart.cart_line_items.group(:shape_id).sum(:quantity)

      sums.each do |shape_id, quantity|
        if quantity > 1
          # remove individual items
          cart.cart_line_items.where(shape_id: shape_id).delete_all

          # replace with a single item
          item = cart.cart_line_items.build(shape_id: shape_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items

    ###does the below line need to be CartLineItem?
    LineItem.where("quantity>1").each do |cart_line_item|
      # add individual items


      cart_line_item.quantity.times do
        ###does the below line need to be CartLineItem?
        LineItem.create cart_id: cart_line_item.cart_id,
                        shape_id: cart_line_item.shape_id
      end

      # remove original item
      cart_line_item.destroy
    end
  end
end