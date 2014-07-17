class User < ActiveRecord::Base
  has_many :authorizations do
    def create_from_auth_hash(auth_hash)
      token = auth_hash["credentials"]["token"] if auth_hash["credentials"]

      self.create(:uid => auth_hash["uid"],
                  :provider => auth_hash["provider"],
                  :token => token)
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

  def github_repos
    gh_auth = authorizations.find_by_provider("github")
    if gh_auth && gh_auth.token.present?
      client = OAuth2::Client.new(Rails.application.secrets.github_key,
                                  Rails.application.secrets.github_secret,
                                  :site => "https://api.github.com")
      token = OAuth2::AccessToken.new(client, gh_auth.token)
      token.get("/user/repos").parsed
    end
  end

  def to_s
    "#{name} <#{email}>"
  end
end
