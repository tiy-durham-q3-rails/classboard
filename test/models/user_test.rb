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

  test "user authorized via GitHub can get their GH repos" do
    gh_auth = authorizations(:student_gh)
    gh_response = File.read(fixture_path + "files/gh_repos.json")

    stub_request(:get, "https://api.github.com/user/repos").
        with(:headers => {'Authorization'=>"Bearer #{gh_auth.token}"}).
        to_return(:status => 200, :body => gh_response, :headers => {"Content-Type" => "application/json"})

    user = users(:student)
    gh_repos = JSON.parse(gh_response)

    assert_equal gh_repos, user.github_repos
  end

end
