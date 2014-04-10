class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
  	:omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :annotations

  def self.find_for_google_oauth2(auth, blah = nil)
    if user = User.find_by_email(auth.info.email)
      user.access_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.token_expires_at = auth.credentials.expires_at if auth.credentials.expires_at
      user.save

      user
    else
      where(auth.slice(:email)).first_or_create do |user|
        user.email    = auth.info.email
        user.access_token = auth.credentials.token
        user.refresh_token = auth.credentials.refresh_token
        user.token_expires_at = auth.credentials.expires_at if auth.credentials.expires_at

        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
