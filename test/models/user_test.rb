require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "add_provider will add an authorization" do
    assert_difference('Authorization.count') do
      users(:teacher).add_provider("provider" => "test", "uid" => "12345")
    end
  end

  test "add_provider will not add the same authorization twice" do
    user = users(:teacher)
    auth = user.authorizations.first

    assert_no_difference('Authorization.count') do
      user.add_provider("provider" => auth.provider, "uid" => auth.uid)
    end
  end

  test "setting teacher to true sets teacher? to true" do
    user = users(:student)
    refute user.teacher?

    user.teacher = true
    assert user.teacher?
  end

end
