require 'test_helper'

class CartLineItemsControllerTest < ActionController::TestCase
  setup do
    @cart_line_item = cart_line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_line_item" do
    assert_difference('CartLineItem.count') do
      #below seems to not be needed p112
      #post :create, cart_line_item: { cart_id: @cart_line_item.cart_id, shape_id: @cart_line_item.shape_id }
      post :create, shape_id: shapes(:animals_1).id
    end
    assert_redirected_to cart_path(assigns(:cart_line_item).cart)
    #below seems to not be needed p112
    #assert_redirected_to cart_line_item_path(assigns(:cart_line_item))
  end

  test "should show cart_line_item" do
    get :show, id: @cart_line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart_line_item
    assert_response :success
  end

  test "should update cart_line_item" do
    put :update, id: @cart_line_item, cart_line_item: { cart_id: @cart_line_item.cart_id, shape_id: @cart_line_item.shape_id }
    assert_redirected_to cart_line_item_path(assigns(:cart_line_item))
  end

  test "should destroy cart_line_item" do
    assert_difference('CartLineItem.count', -1) do
      delete :destroy, id: @cart_line_item
    end

    assert_redirected_to cart_line_items_path
  end
end
