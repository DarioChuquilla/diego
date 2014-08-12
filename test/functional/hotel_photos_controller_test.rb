require 'test_helper'

class HotelPhotosControllerTest < ActionController::TestCase
  setup do
    @hotel_photo = hotel_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hotel_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hotel_photo" do
    assert_difference('HotelPhoto.count') do
      post :create, hotel_photo: {  }
    end

    assert_redirected_to hotel_photo_path(assigns(:hotel_photo))
  end

  test "should show hotel_photo" do
    get :show, id: @hotel_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hotel_photo
    assert_response :success
  end

  test "should update hotel_photo" do
    put :update, id: @hotel_photo, hotel_photo: {  }
    assert_redirected_to hotel_photo_path(assigns(:hotel_photo))
  end

  test "should destroy hotel_photo" do
    assert_difference('HotelPhoto.count', -1) do
      delete :destroy, id: @hotel_photo
    end

    assert_redirected_to hotel_photos_path
  end
end
