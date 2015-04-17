require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @wrong_user = users(:wrong_user)
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

  test "should redirect edit when not logged in" do
    get :edit, id: events(:one).id, user_id: @user
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as the wrong user" do
    log_in_as @wrong_user
    get :edit, id: events(:one).id, user_id: @user
    assert_redirected_to root_url
  end

  test "should get edit when logged in as the right user" do
    log_in_as @user
    get :edit, id: events(:one).id, user_id: @user
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
    assert_redirected_to user_events_url(@user)
  end

  test "should redirect update when not logged in" do
    patch :update, id: events(:one), user_id: @user,  event: { title:    "Lorem ipsum",
                                                               date:     5.days.from_now,
                                                               location: "Lorem ipsum" }
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as the wrong user" do
    log_in_as @wrong_user
    patch :update, id: events(:one), user_id: @user, event: { title:    "Lorem ipsum",
                                                              date:     5.days.from_now,
                                                              location: "Lorem ipsum" }
    assert_redirected_to root_url
  end

  test "should update event when logged in as the right user" do
    log_in_as @user
    patch :update, id: events(:one), user_id: @user, event: { title:    "Lorem ipsum",
                                                              date:     5.days.from_now,
                                                              location: "Lorem ipsum" }
    assert_redirected_to user_events_url(@user)
  end
end
