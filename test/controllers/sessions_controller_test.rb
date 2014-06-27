require "test_helper"

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_response :success
  end

  test "can login if authorized" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:teacher]
    post :create, provider: 'github'

    assert_redirected_to root_url
  end

  test "cannot login if not authorized" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:joker]
    post :create, provider: 'github'

    assert_redirected_to login_path
  end

end
