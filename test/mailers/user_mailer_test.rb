require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Activate Your Account", mail.subject
    assert_equal ["michael@example.com"], mail.to
    assert_equal ["noreply@rocky-ocean-5667.herokuapp.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@rocky-ocean-5667.herokuapp.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
