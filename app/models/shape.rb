class Shape < ActiveRecord::Base
  has_many :line_items
  has_many :orders, through: :cart_line_items

  before_destroy :ensure_not_referenced_by_any_line_item
                 :ensure_not_referenced_by_any_cart_line_item

  attr_accessible :image_url, :lrg_image_url, :price, :shape_type, :text, :text_type, :title
  validates :title, :text, :text_type, :shape_type, :price, :lrg_image_url, :image_url, presence: true
  validates :title, uniqueness: true

  validates :image_url, allow_blank: true, format: {
      with:    %r{\.(gif|jpg|png)\Z}i,
      message: 'must be a URL for GIF, JPG or PNG image.'
  }

  belongs_to :user

  private
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  # ensure that there are no cart line items referencing this product
  def ensure_not_referenced_by_any_cart_line_item
    if cart_line_items.empty?
      return true
    else
      errors.add(:base, 'Cart Line Items present')
      return false
    end
  end

end

