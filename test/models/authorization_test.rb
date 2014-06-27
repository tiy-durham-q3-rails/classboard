require "test_helper"

class AuthorizationTest < ActiveSupport::TestCase
  test "self.find_or_create creates an authorization if not present" do
    assert_difference('Authorization.count') do
      auth = Authorization.find_or_create(
          "provider" => "test",
          "uid" => "newuser@example.org",
          "info" => {"name" => "New User",
                     "email" => "new_user@example.org"}
      )

      assert_equal "newuser@example.org", auth.uid
    end
  end

  test "self.find_or_create creates a user if not present" do
    assert_difference('User.count') do
      auth = Authorization.find_or_create(
          "provider" => "test",
          "uid" => "newuser@example.org",
          "info" => {"name" => "New User",
                     "email" => "new_user@example.org"}
      )

      assert_equal "New User", auth.user.name
      assert_equal "new_user@example.org", auth.user.email
    end
  end

  test "self.find_or_create does not creates an authorization if present" do
    auth = Authorization.create!(provider: "test", uid: "12345")

    assert_no_difference('Authorization.count') do
      Authorization.find_or_create("provider" => "test", "uid" => "12345")
    end
  end

end
