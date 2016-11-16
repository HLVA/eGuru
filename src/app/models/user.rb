class User < ApplicationRecord
  include Clearance::User

  mount_uploader :avatar, AvatarUploader
  has_many :conversations, dependent: :destroy
  # def self.from_omniauth(auth)
  #   where(auth.slice(:privider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.auth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save
  #   end
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email  = auth.uid.to_s + "@dummy.com"
      user.encrypted_password = ""
      user.save(:validate => false)
    end
  end

  def display_name
    if provider.present?
      return name
    else
      return email
    end
  end

end
