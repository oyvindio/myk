require 'test_helper'

class MykurlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mykurls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mykurl" do
    assert_difference('Mykurl.count') do
      post :create, :mykurl => { }
    end

    assert_redirected_to mykurl_path(assigns(:mykurl))
  end

  test "should show mykurl" do
    get :show, :id => mykurls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mykurls(:one).to_param
    assert_response :success
  end

  test "should update mykurl" do
    put :update, :id => mykurls(:one).to_param, :mykurl => { }
    assert_redirected_to mykurl_path(assigns(:mykurl))
  end

  test "should destroy mykurl" do
    assert_difference('Mykurl.count', -1) do
      delete :destroy, :id => mykurls(:one).to_param
    end

    assert_redirected_to mykurls_path
  end
end
