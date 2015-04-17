require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
    @guest = @event.guests.build(name: "Foobar")
  end

  test "should be valid" do
    assert @guest.valid?
  end

  test "should require a name" do
    @guest.name = nil
    assert_not @guest.valid?
  end

  test "should require name to be <= 140 chars" do
    @guest.name = "a" * 141
    assert_not @guest.valid?
  end
end
