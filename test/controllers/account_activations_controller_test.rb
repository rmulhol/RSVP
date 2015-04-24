require 'test_helper'

class AccountActivationsControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @wrong_user = users(:wrong_user)
  end

  test "should redirect new when not logged in" do
    get :new, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect new when logged in as the wrong user" do
    log_in_as @wrong_user
    get :new, user_id: @user
    assert_redirected_to root_url
  end

  test "should get new when logged in as the right user" do
    log_in_as @user
    get :new, user_id: @user
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post :create, user_id: @user, account_activation: { email: "test@test.com" }
    assert_redirected_to login_url
  end

  test "should redirect create when logged in as the wrong user" do
    log_in_as @wrong_user
    post :create, user_id: @user, account_activation: { email: "test@test.com" }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should re-render new on invalid email address" do
    log_in_as @user
    post :create, user_id: @user, account_activation: { email: "" }
    assert_equal "Please enter a valid email address", flash[:danger]
    assert_template "account_activations/new"
  end

  test "should create when logged in as the right user and valid email" do
    log_in_as @user
    post :create, user_id: @user, account_activation: { email: "test@test.com" }
    assert_equal "Please check your email to activate your account", flash[:info]
    assert_redirected_to @user
  end

  test "should redirect edit when activation token is invalid" do
    get :edit, id: "invalid", email: users(:activating_user).email
    assert_equal "Invalid activation link", flash[:danger]
    assert_redirected_to root_url
  end

  test "should activate user when activation token is valid" do
    activating_user = users(:activating_user)
    get :edit, id: "activation", email: activating_user.email
    assert_equal "Account activated!", flash[:success]
    assert_redirected_to activating_user
  end
end