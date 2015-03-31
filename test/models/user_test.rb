require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should require name" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "should require email" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "should limit name length to 50 chars" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "should limit email length to 200 chars" do
    @user.email = "a" * 189 + "@example.com"
    assert_not @user.valid?
  end

  test "should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "should require email addresses to be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should require password to be at least 6 chars" do
    @user.password = @user.password_confirmation = "fobar"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
end