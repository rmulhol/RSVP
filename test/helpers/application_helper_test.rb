require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  
  test "should provide base title if no page title given" do
    assert_equal "RSVP App", full_title
  end

  test "should interpolate given page title" do
    assert_equal "Help | RSVP App", full_title("Help")
  end
end
