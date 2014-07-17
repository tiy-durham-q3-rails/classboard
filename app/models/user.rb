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

  def github_access_token
    gh_auth = authorizations.find_by_provider("github")
    gh_auth.token if gh_auth
  end

  def github_token
    return @gh_token if @gh_token

    if github_access_token
      gh_client = OAuth2::Client.new(Rails.application.secrets.github_key,
                                  Rails.application.secrets.github_secret,
                                  :site => "https://api.github.com")
      @gh_token = OAuth2::AccessToken.new(gh_client, github_access_token)
    end
    @gh_token
  end

  def github_repos
    github_token.get("/user/repos").parsed if github_token
  end

  def to_s
    "#{name} <#{email}>"
  end
end
