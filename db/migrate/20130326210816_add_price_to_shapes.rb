class AddPriceToShapes < ActiveRecord::Migration
  def change
    add_column :shapes, :price, :decimal
  end
end
