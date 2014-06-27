require "test_helper"

class HelpRequestsControllerTest < ActionController::TestCase

  def user
    @user ||= users(:teacher)
  end

  def setup
    login(user)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:help_requests)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    help_request = help_requests(:one)

    assert_difference('HelpRequest.count') do
      post :create, help_request: { attempted: help_request.attempted, nature: help_request.nature }
    end

    assert_redirected_to help_requests_path
  end

  def test_show
    help_request = help_requests(:one)
    get :show, id: help_request
    assert_response :success
  end

  def test_edit
    help_request = help_requests(:one)
    login(help_request.user)
    get :edit, id: help_request
    assert_response :success
  end

  def test_update
    help_request = help_requests(:one)
    login(help_request.user)
    put :update, id: help_request, help_request: { attempted: help_request.attempted, nature: help_request.nature }
    assert_redirected_to help_requests_path
  end

  def test_resolve
    help_request = help_requests(:one)
    put :resolve, id: help_request
    assert assigns(:help_request).resolved?
    assert_redirected_to help_requests_path
  end
end
