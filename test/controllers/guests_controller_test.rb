require 'test_helper'

class GuestsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:michael)
    @event = events(:one)
    @guest = guests(:guest_one)
  end

  test "should get new" do
    get :new, event_id: @event, id: @guest
    assert_response :success
  end

  test "should create new guest and redirect to root if user is not event owner" do
    log_in_as users(:wrong_user)
    assert_difference "Guest.count", 1 do
      post :create, event_id: @event, guest: { name: "Foo Bar", responsibility: "" }
    end
    assert_redirected_to root_url
  end

  test "should create new guest and redirect to event if user is event owner" do
    log_in_as @user
    assert_difference "Guest.count", 1 do
      post :create, event_id: @event, guest: { name: "Foo Bar", responsibility: "" }
    end
    assert_redirected_to user_event_path(@event, user_id: @user)
  end

  test "should redirect edit when not logged in" do
    get :edit, event_id: @event, id: @guest
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as users(:wrong_user)
    get :edit, event_id: @event, id: @guest
    assert_redirected_to root_url
  end

  test "should get edit when logged in as the right user" do
    log_in_as @user
    get :edit, event_id: @event, id: @guest
    assert_template "guests/edit"
  end

  test "should redirect update when not logged in" do
    patch :update, event_id: @event, id: @guest, guest: { name: "Wrong User", responsibility: "" }
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as users(:wrong_user)
    patch :update, event_id: @event, id: @guest, guest: { name: "Wrong User", responsibility: "" }
    assert_redirected_to root_url
  end

  test "should update when logged in as the right user" do
    log_in_as @user
    patch :update, event_id: @event, id: @guest, guest: { name: "Correct User", responsibility: "" }
    assert_redirected_to user_event_path(@event, user_id: @user)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Guest.count" do
      delete :destroy, event_id: @event, id: @guest
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as the wrong user" do
    log_in_as users(:wrong_user)
    assert_no_difference "Guest.count" do
      delete :destroy, event_id: @event, id: @guest
    end
    assert_redirected_to root_url
  end

  test "should destroy when logged in" do
    log_in_as @user
    assert_difference "Guest.count", -1 do
      delete :destroy, event_id: @event, id: @guest
    end
  end
end
