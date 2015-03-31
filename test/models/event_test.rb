require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
  def setup
    @event = Event.new(title: "Example Event", date: 5.days.from_now,
                       location: "Example Location", user: users(:michael))
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "title should be present" do
    @event.title = ""
    assert_not @event.valid?
  end

  test "date should be present" do
    @event.date = ""
    assert_not @event.valid?
  end

  test "location should be present" do
    @event.location = ""
    assert_not @event.valid?
  end

  test "title should not be longer than 100 chars" do
    @event.title = "a" * 101
    assert_not @event.valid?
  end

  test "location should not be longer than 255 chars" do
    @event.location = "a" * 256
    assert_not @event.valid?
  end
end
