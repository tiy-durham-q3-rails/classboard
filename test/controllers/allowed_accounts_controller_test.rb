require 'test_helper'

class AllowedAccountsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create, :allowed_account => {:github => "fooooooo"}
    assert_response :redirect
  end

  test "should get destroy" do
    get :destroy, :id => AllowedAccount.last.id
    assert_response :redirect
  end

end
