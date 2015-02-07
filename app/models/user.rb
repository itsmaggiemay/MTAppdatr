class User < ActiveRecord::Base
  has_many :friends

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid= auth["uid"]
      user.name = auth["info"]["name"] || ""
      user.avatar = auth["info"]["image"] || ""
      user.oauth_token = auth["credentials"]["token"] || ""
      user.oauth_secret = auth["credentials"]["secret"] || ""
    end
  end

end
