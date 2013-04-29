class LineItem < ActiveRecord::Base
  belongs_to :shape
  belongs_to :row
  attr_accessible :row_id, :shape_id
end
