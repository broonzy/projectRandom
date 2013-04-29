class AddUserIdToShapes < ActiveRecord::Migration
  def change
    add_column :shapes, :user_id, :integer
  end
end
