require 'test_helper'

class Admin::HotelsControllerTest < ActionController::TestCase
  setup do
    @admin_hotel = admin_hotels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_hotels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_hotel" do
    assert_difference('Admin::Hotel.count') do
      post :create, admin_hotel: { address: @admin_hotel.address, description: @admin_hotel.description, latitude: @admin_hotel.latitude, longitude: @admin_hotel.longitude, name: @admin_hotel.name }
    end

    assert_redirected_to admin_hotel_path(assigns(:admin_hotel))
  end

  test "should show admin_hotel" do
    get :show, id: @admin_hotel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_hotel
    assert_response :success
  end

  test "should update admin_hotel" do
    put :update, id: @admin_hotel, admin_hotel: { address: @admin_hotel.address, description: @admin_hotel.description, latitude: @admin_hotel.latitude, longitude: @admin_hotel.longitude, name: @admin_hotel.name }
    assert_redirected_to admin_hotel_path(assigns(:admin_hotel))
  end

  test "should destroy admin_hotel" do
    assert_difference('Admin::Hotel.count', -1) do
      delete :destroy, id: @admin_hotel
    end

    assert_redirected_to admin_hotels_path
  end
end
