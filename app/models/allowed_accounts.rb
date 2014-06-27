class AllowedAccounts < ActiveRecord::Base
  validate :github, presence: true

  def self.check_if_allowed(auth_hash)
    if auth_hash['provider'] == 'github'
      self.find_by_github(auth_hash['info']['nickname'])
    else
      Rails.env.development? && auth_hash['provider'] == 'developer'
    end
  end
end
