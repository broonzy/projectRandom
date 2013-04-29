class AddLrgImageUrlToShape < ActiveRecord::Migration
  def change
    add_column :shapes, :lrg_image_url, :string
  end
end
