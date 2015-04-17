require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @wrong_user = users(:wrong_user)
  end

  test "should redirect show when not logged in" do
    get :show, id: @user
    assert_redirected_to login_url
  end

  test "should redirect show when logged in as the wrong user" do
    log_in_as @wrong_user
    get :show, id: @user
    assert_redirected_to root_url
  end

  test "should show user when logged in as the right user" do
    log_in_as @user
    get :show, id: @user
    assert_response :success
    assert_template "users/show"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign Up | RSVP App"
  end

  test "should create new user" do
    assert_difference "User.count", 1 do
      post :create, user: { name: "New User", email: "new@new.new", password: "password", password_confirmation: "password" }
    end
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as @wrong_user
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should get edit when logged in as the right user" do
    log_in_as @user
    get :edit, id: @user
    assert_response :success
  end

  test "should redirect update when not logged in" do
    post :update, id: @user, user: { name: "Anonymous User", email: "anon@example.org", password: "password", password_confirmation: "password" }
    @user.reload
    assert_not_equal @user.name, "Anonymous User"
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as @wrong_user
    post :update, id: @user, user: { name: "Wrong User", email: "wrong@example.org", password: "password", password_confirmation: "password" }
    @user.reload
    assert_not_equal @user.name, "Wrong User"
    assert_redirected_to root_url
  end

  test "should update successfully when logged in as the right user" do
    log_in_as @user
    post :update, id: @user, user: { name: "New Name", email: "new@example.org", password: "password", password_confirmation: "password" }
    @user.reload
    assert_equal @user.name, "New Name"
    assert_redirected_to @user
  end
end
