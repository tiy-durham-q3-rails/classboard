require "test_helper"

class AuthorizationTest < ActiveSupport::TestCase

  def authorization
    @authorization ||= build(:authorization)
  end

  def test_valid
    assert authorization.valid?
  end

  test "self.find_or_create creates an authorization if not present" do
    user_attributes = attributes_for(:user)

    assert_difference('Authorization.count') do
      auth = Authorization.find_or_create(
          "provider" => "test",
          "uid" => user_attributes[:email],
          "info" => {"name" => user_attributes[:name],
                     "email" => user_attributes[:email]}
      )

      assert_equal user_attributes[:email], auth.uid
    end
  end

  test "self.find_or_create creates a user if not present" do
    user_attributes = attributes_for(:user)

    assert_difference('User.count') do
      auth = Authorization.find_or_create(
          "provider" => "test",
          "uid" => user_attributes[:email],
          "info" => {"name" => user_attributes[:name],
                     "email" => user_attributes[:email]}
      )

      assert_equal user_attributes[:name], auth.user.name
      assert_equal user_attributes[:email], auth.user.email
    end
  end

  test "self.find_or_create does not creates an authorization if present" do
    auth = create(:authorization, provider: "test", uid: "12345")

    assert_no_difference('Authorization.count') do
      Authorization.find_or_create("provider" => "test", "uid" => "12345")
    end
  end

end
