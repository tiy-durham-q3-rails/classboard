ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
end

class ActionController::TestCase
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:teacher] = { 'provider' => 'github',
                                          'uid' => 'teacher',
                                          'info' => {
                                            'nickname' => 'teacher',
                                            'name' => 'teacher',
                                            'email' => 'teacher@example.org'}}

  OmniAuth.config.mock_auth[:joker] = { 'provider' => 'github',
                                        'uid' => 'joker',
                                        'info' => {
                                          'nickname' => 'joker',
                                          'name' => 'joker',
                                          'email' => 'joker@example.org'}}

  def login(user = nil)
    if user.nil?
      user = users(:teacher)
    end
    @request.env["rack.session"]["user_id"] = user.id
  end
end
