class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.github_avatar = auth.info.image
      user.nickname = auth.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end

  def picture_url
    if github_avatar.blank?
      return "https://eu.ui-avatars.com/api/?name=#{email}&background=ffa34d&color=fff"
    else
      return github_avatar
    end
  end
end
