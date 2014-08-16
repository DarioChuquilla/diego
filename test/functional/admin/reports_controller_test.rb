require 'test_helper'

class Admin::ReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get received" do
    get :received
    assert_response :success
  end

  test "should get done" do
    get :done
    assert_response :success
  end

end
