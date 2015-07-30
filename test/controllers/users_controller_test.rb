require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:test_user)
    @other_user = users(:test_user_2)
    @admin = users(:test_admin)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get :show, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not redirect show when logged in as admin" do
    log_in_as(@admin)
    get :show, id: @user
    assert_response :success
  end

  test "should not redirect edit when logged in as admin" do
    log_in_as(@admin)
    get :edit, id: @user
    assert_response :success
  end
  
  test "should redirect show when logged in as wrong user" do
    log_in_as(@other_user)
    get :show, id: @user
    assert flash.present?
    assert_redirected_to root_path
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.present?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name }
    assert flash.present?
    assert_redirected_to root_path
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to root_path
  end  
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_path
  end
  
end
