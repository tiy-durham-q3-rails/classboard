require "test_helper"

class HelpRequestsControllerTest < ActionController::TestCase

  def user
    @user ||= create(:user)
  end

  def setup
    login(user)
  end

  def test_index
    @request.env["rack.session"]["user_id"] = 1
    get :index
    assert_response :success
    assert_not_nil assigns(:help_requests)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    help_request = build(:help_request)

    assert_difference('HelpRequest.count') do
      post :create, help_request: { attempted: help_request.attempted, nature: help_request.nature }
    end

    assert_redirected_to help_requests_path
  end

  def test_show
    help_request = create(:help_request)
    get :show, id: help_request
    assert_response :success
  end

  def test_edit
    help_request = create(:help_request)
    get :edit, id: help_request
    assert_response :success
  end

  def test_update
    help_request = create(:help_request)
    put :update, id: help_request, help_request: { attempted: help_request.attempted, nature: help_request.nature }
    assert_redirected_to help_requests_path
  end

  def test_resolve
    help_request = create(:help_request)
    put :resolve, id: help_request
    assert assigns(:help_request).resolved?
    assert_redirected_to help_requests_path
  end
end
