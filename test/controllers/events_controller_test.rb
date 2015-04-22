require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @wrong_user = users(:wrong_user)
    @event = events(:one)
  end

  test "should redirect index when not logged in" do
    get :index, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect index when logged in as the wrong user" do
    log_in_as @wrong_user
    get :index, user_id: @user
    assert_redirected_to root_url
  end

  test "should get index when logged in as the right user" do
    log_in_as @user
    get :index, user_id: @user
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get :show, id: @event, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect show when logged in as the wrong user" do
    log_in_as @wrong_user
    get :show, id: @event, user_id: @user
    assert_redirected_to root_url
  end

  test "should get show when logged in as the right user" do
    log_in_as @user
    get :show, id: @event, user_id: @user
    assert_response :success
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
    assert_no_difference "Event.count" do 
      post :create, user_id: @user, event: { title:     "Lorem ipsum",
                                             date:      5.days.from_now,
                                             location:  "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect create when logged in as the wrong user" do
    log_in_as @wrong_user
    assert_no_difference "Event.count" do
      post :create, user_id: @user, event: { title:     "Lorem ipsum",
                                             date:      5.days.from_now,
                                             location:  "Lorem ipsum" }
    end
    assert_redirected_to root_url
  end

  test "should create new event when logged in as the right user" do
    log_in_as @user
    assert_difference "Event.count", 1 do 
      post :create, user_id: @user, event: { title:     "Lorem ipsum",
                                             date:      5.days.from_now,
                                             location:  "Lorem ipsum" }
    end
    assert_redirected_to user_url(@user)
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @event, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as @wrong_user
    get :edit, id: @event, user_id: @user
    assert_redirected_to root_url
  end

  test "should get edit when logged in as the right user" do
    log_in_as @user
    get :edit, id: @event, user_id: @user
    assert_response :success
  end

  test "should redirect update when not logged in" do
    patch :update, id: @event, user_id: @user,  event: { title:    "Lorem ipsum",
                                                               date:     5.days.from_now,
                                                               location: "Lorem ipsum" }
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as @wrong_user
    patch :update, id: @event, user_id: @user, event: { title:    "Lorem ipsum",
                                                              date:     5.days.from_now,
                                                              location: "Lorem ipsum" }
    assert_redirected_to root_url
  end

  test "should update event when logged in as the right user" do
    log_in_as @user
    patch :update, id: @event, user_id: @user, event: { title:    "Lorem ipsum",
                                                              date:     5.days.from_now,
                                                              location: "Lorem ipsum" }
    assert_redirected_to user_url(@user)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Event.count" do
      delete :destroy, id: @event, user_id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as the wrong user" do
    log_in_as @wrong_user
    assert_no_difference "Event.count" do
      delete :destroy, id: @event, user_id: @user
    end
    assert_redirected_to root_url
  end

  test "should destroy when logged in as the right user" do
    log_in_as @user
    assert_difference "Event.count", -1 do
      delete :destroy, id: @event, user_id: @user
    end
    assert_redirected_to user_url(@user)
  end

  test "should redirect invite when not logged in" do
    get :invite, id: @event, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect invite when logged in as the wrong user" do
    log_in_as @wrong_user
    get :invite, id: @event, user_id: @user
    assert_redirected_to root_url
  end

  test "should get invite when logged in as the right user" do
    log_in_as @user
    get :invite, id: @event, user_id: @user
    assert_response :success
  end
end
