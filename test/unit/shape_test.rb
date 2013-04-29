  require 'test_helper'

  class ShapeTest < ActiveSupport::TestCase
    fixtures :shapes
    test "shape attributes must not be empty" do
      shape = Shape.new
      assert shape.invalid?
      assert shape.errors[:title].any?
      assert shape.errors[:text].any?
      assert shape.errors[:text_type].any?
      assert shape.errors[:shape_type].any?
      assert shape.errors[:image_url].any?
      assert shape.errors[:lrg_image_url].any?
      assert shape.errors[:shape_type].any?
      assert shape.errors[:price].any?
    end

    test "shape price must be positive" do
      shape = Shape.new(title:       "Title",
                            text: "yyy",
                            text_type: "yyy",
                            shape_type: "yyy",
                            image_url:   "zzz.jpg",
                            lrg_image_url:   "zzz.jpg")
      shape.price = -1
      assert shape.invalid?
      assert_equal ["must be greater than or equal to 0.01"],
                   shape.errors[:price]

      shape.price = 0
      assert shape.invalid?
      assert_equal ["must be greater than or equal to 0.01"],
                   shape.errors[:price]

      shape.price = 1
      assert shape.valid?
    end

    def new_shape(image_url)
      Shape.new(title:       "My Title",
                  text: "yyy",
                  text_type: "xxx",
                  shape_type: "ppp",
                  image_url:   image_url,
                  lrg_image_url:   image_url,
                  price:   1)
    end

    test "image url" do
      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
      bad = %w{ fred.doc fred.gif/more fred.gif.more }

      ok.each do |name|
        assert new_shape(name).valid?, "#{name} shouldn't be invalid"
      end

      bad.each do |name|
        assert new_shape(name).invalid?, "#{name} shouldn't be valid"
      end
    end

    test "shape is not valid without a unique title" do
      shape = Shape.new(title:       shapes(:animals_1).title,
                            text: "yyy",
                            text_type: "xxx",
                            shape_type: "ppp",
                            price:       1,
                            image_url:   "fred.gif",
                            lrg_image_url:   "fred.gif")

      assert shape.invalid?
      assert_equal ["has already been taken"], shape.errors[:title]
    end

    test "shape is not valid without a unique title - i18n" do
      shape = Shape.new(title:       shapes(:animals_1).title,
                            text: "yyy",
                            text_type: "xxx",
                            shape_type: "ppp",
                            price:       1,
                            image_url:   "fred.gif",
                            lrg_image_url:   "fred.gif")

      assert shape.invalid?
      assert_equal [I18n.translate('activerecord.errors.messages.taken')],
                   shape.errors[:title]
    end

  end