class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :shape_id
      t.integer :row_id

      t.timestamps
    end
  end
end
