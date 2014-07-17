class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

    if auth
      auth.update(:token => auth_hash["credentials"]["token"])
    else
      user = User.create!(:name => auth_hash["info"]["name"],
                          :email => auth_hash["info"]["email"],
                          :github => auth_hash["info"]["nickname"])
      auth = user.authorizations.create_from_auth_hash(auth_hash)
    end

    auth
  end
end
