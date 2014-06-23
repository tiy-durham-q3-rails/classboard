require "test_helper"

class UserTest < ActiveSupport::TestCase

  def user
    @user ||= build(:user)
  end

  def test_valid
    assert user.valid?
  end

  test "add_provider will add an authorization" do
    user = create(:user)

    assert_difference('Authorization.count') do
      user.add_provider("provider" => "test", "uid" => "12345")
    end
  end

  test "add_provider will not add the same authorization twice" do
    user = create(:user_with_authorization)
    auth = user.authorizations.first

    assert_no_difference('Authorization.count') do
      user.add_provider("provider" => auth.provider, "uid" => auth.uid)
    end
  end

  test "setting teacher to true sets teacher? to true" do
    user = build(:user, :teacher => false)
    refute user.teacher?

    user.teacher = true
    assert user.teacher?
  end

end
