class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
  	:omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(auth, blah = nil)
    if user = User.find_by_email(auth.info.email)
      user
    else
      where(auth.slice(:email)).first_or_create do |user|
        user.email    = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
