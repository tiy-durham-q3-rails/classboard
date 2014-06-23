ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  def login(user = nil)
    if user.nil?
      user = create(:user)
    end
    @request.env["rack.session"]["user_id"] = user.id
  end
end
