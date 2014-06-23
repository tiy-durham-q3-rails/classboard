class User < ActiveRecord::Base
  has_many :authorizations
  has_many :help_requests

  validates :name, :email, :presence => true

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      authorizations.create :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  def to_s
    name
  end
end
