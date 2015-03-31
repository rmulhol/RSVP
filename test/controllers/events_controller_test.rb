require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index when logged in" do
    log_in_as users(:michael)
    get :index
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as users(:michael)
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: events(:one).id
    assert_redirected_to login_url
  end

  test "should get edit when logged in" do
    log_in_as users(:michael)
    get :edit, id: events(:one).id
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Event.count" do 
      post :create, event: { title: "Lorem ipsum",
                             date: 5.days.from_now,
                             location: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should create new event when logged in" do
    log_in_as users(:michael)
    assert_difference "Event.count", 1 do 
      post :create, event: { title: "Lorem ipsum",
                             date: 5.days.from_now,
                             location: "Lorem ipsum" }
    end
    assert_redirected_to events_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: events(:one), event: { title:    "Lorem ipsum",
                                                date:     5.days.from_now,
                                                location: "Lorem ipsum" }
    assert_redirected_to login_url
  end

  test "should update event when logged in" do
    log_in_as users(:michael)
    patch :update, id: events(:one), event: { title:    "Lorem ipsum",
                                                date:     5.days.from_now,
                                                location: "Lorem ipsum" }
    assert_redirected_to events_url
  end
end