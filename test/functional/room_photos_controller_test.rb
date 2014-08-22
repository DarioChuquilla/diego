require 'test_helper'

class RoomPhotosControllerTest < ActionController::TestCase
  setup do
    @room_photo = room_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:room_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create room_photo" do
    assert_difference('RoomPhoto.count') do
      post :create, room_photo: {  }
    end

    assert_redirected_to room_photo_path(assigns(:room_photo))
  end

  test "should show room_photo" do
    get :show, id: @room_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @room_photo
    assert_response :success
  end

  test "should update room_photo" do
    put :update, id: @room_photo, room_photo: {  }
    assert_redirected_to room_photo_path(assigns(:room_photo))
  end

  test "should destroy room_photo" do
    assert_difference('RoomPhoto.count', -1) do
      delete :destroy, id: @room_photo
    end

    assert_redirected_to room_photos_path
  end
end
