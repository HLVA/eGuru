class User < ApplicationRecord
  include Clearance::User

  mount_uploader :avatar, AvatarUploader
  has_many :conversations, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

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

  def self.users_are_not_already_friends (current_user)
    if current_user.friends.present?
	   User.where("(id not in (?)) and (id != ?)", current_user.friend_ids, current_user.id)
   else
    User.where("(id != ?)", current_user.id)
   end
  end

end
