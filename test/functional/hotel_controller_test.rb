require 'test_helper'

class HotelControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get nearest" do
    get :nearest
    assert_response :success
  end

  test "should get price" do
    get :price
    assert_response :success
  end

  test "should get cities" do
    get :cities
    assert_response :success
  end

  test "should get promo" do
    get :promo
    assert_response :success
  end

end
