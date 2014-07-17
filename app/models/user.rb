class User < ActiveRecord::Base
  has_many :authorizations do
    def create_from_auth_hash(auth_hash)
      self.create(:uid => auth_hash["uid"],
                  :provider => auth_hash["provider"],
                  :token => auth_hash["credentials"]["token"])
    end
  end
  has_many :help_requests
  has_one :allowed_account, :foreign_key => "github", :primary_key => "github"

  validates :name, :email, :presence => true

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      authorizations.create_from_auth_hash(auth_hash)
    end
  end

  def authorized?
    allowed_account.present?
  end

  def to_s
    "#{name} <#{email}>"
  end
end
