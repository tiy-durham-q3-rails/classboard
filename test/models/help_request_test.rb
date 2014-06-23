require "test_helper"

class HelpRequestTest < ActiveSupport::TestCase

  test "it is resolved if resolved_at is not nil" do
    assert build(:help_request, resolved_at: Time.now).resolved?
  end

  test "it is not resolved if resolved_at is nil" do
    refute build(:help_request, resolved_at: nil).resolved?
  end

  test "it can be resolved" do
    help_request = build(:help_request)
    help_request.resolve!
    assert help_request.resolved?
  end

  test "resolve! resolves it at current time" do
    help_request = build(:help_request)
    help_request.resolve!

    assert_in_delta Time.zone.now.to_i,
                    help_request.resolved_at.to_i,
                    10,
                    "Should be resolved at current time"
  end

  test "user_name returns user's name if present" do
    help_request = build(:help_request)
    assert_equal help_request.user.name, help_request.user_name
  end

  test "user_name returns nil if not present" do
    help_request = build(:help_request, user: nil)
    assert_nil help_request.user_name
  end

  test "the creator of a help request has resolve authority" do
    help_request = build(:help_request)
    assert help_request.can_resolve?(help_request.user)
  end

  test "a teacher has resolve authority" do
    teacher = build(:user, teacher: true)
    help_request = build(:help_request)
    assert help_request.can_resolve?(teacher)
  end

  test "others do not have resolve authority" do
    help_request = build(:help_request)
    refute help_request.can_resolve?(build(:user))
  end

  test "the creator of a help request has edit authority" do
    help_request = build(:help_request)
    assert help_request.can_edit?(help_request.user)
  end

  test "a teacher does not have edit authority" do
    teacher = build(:user, teacher: true)
    help_request = build(:help_request)
    refute help_request.can_edit?(teacher)
  end

  test "others do not have edit authority" do
    help_request = build(:help_request)
    refute help_request.can_edit?(build(:user))
  end
end
