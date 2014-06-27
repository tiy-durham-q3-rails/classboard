require "test_helper"

class HelpRequestTest < ActiveSupport::TestCase
  setup do
    @help_request = help_requests(:one)
  end

  test "it is resolved if resolved_at is not nil" do
    assert HelpRequest.new(resolved_at: Time.now).resolved?
  end

  test "it is not resolved if resolved_at is nil" do
    refute HelpRequest.new(resolved_at: nil).resolved?
  end

  test "it can be resolved" do
    help_request = HelpRequest.new
    help_request.resolve!
    assert help_request.resolved?
  end

  test "resolve! resolves it at current time" do
    help_request = HelpRequest.new
    help_request.resolve!

    assert_in_delta Time.zone.now.to_i,
                    help_request.resolved_at.to_i,
                    10,
                    "Should be resolved at current time"
  end

  test "user_name returns user's name if present" do
    assert_equal @help_request.user.name, @help_request.user_name
  end

  test "user_name returns nil if not present" do
    help_request = HelpRequest.new(user: nil)
    assert_nil help_request.user_name
  end

  test "the creator of a help request has resolve authority" do
    assert @help_request.can_resolve?(@help_request.user)
  end

  test "a teacher has resolve authority" do
    teacher = users(:teacher)
    assert @help_request.can_resolve?(teacher)
  end

  test "others do not have resolve authority" do
    refute @help_request.can_resolve?(users(:charlotte))
  end

  test "the creator of a help request has edit authority" do
    assert @help_request.can_edit?(@help_request.user)
  end

  test "a teacher does not have edit authority" do
    teacher = users(:teacher)
    refute @help_request.can_edit?(teacher)
  end

  test "others do not have edit authority" do
    refute @help_request.can_edit?(users(:charlotte))
  end

  test "a request is late after one day" do
    help_request = HelpRequest.new
    help_request.created_at = Time.zone.now - 1.day
    assert help_request.late?
  end

  test "a request is not late before one day passes" do
    help_request = HelpRequest.new
    help_request.created_at = Time.zone.now
    refute help_request.late?
  end
end