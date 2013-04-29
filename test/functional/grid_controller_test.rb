
require 'test_helper'
class GridControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'animals_1'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for grid.js.coffee is in place" do
    get :index
    assert_select '.grid .entry > img', 3
    assert_select '.entry input[type=submit]', 3
  end
end
