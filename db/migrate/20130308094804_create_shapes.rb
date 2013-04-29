class CreateShapes < ActiveRecord::Migration
  def change
    create_table :shapes do |t|
      t.string :title
      t.text :text
      t.string :text_type
      t.string :image_url
      t.string :shape_type

      t.timestamps
    end
  end
end
