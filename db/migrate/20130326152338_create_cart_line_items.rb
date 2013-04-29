class CreateCartLineItems < ActiveRecord::Migration
  def change
    create_table :cart_line_items do |t|
      t.integer :shape_id
      t.integer :cart_id

      t.timestamps
    end
  end
end
