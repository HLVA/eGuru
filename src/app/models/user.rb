class User < ApplicationRecord
  include Clearance::User
  mount_uploader :avatar, AvatarUploader

  mount_uploader :avatar, AvatarUploader
  has_many :conversations, dependent: :destroy, foreign_key: :recipient_id
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :friend_requests, class_name:"Friendship", foreign_key: :friend_id

  def self.from_omniauth(auth)
    @user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.avatar = auth.info.image
      if auth.info.email.present?
        user.email  = auth.info.email
      else
        user.email = auth.uid.to_s + "@dummy.com"
      end
      user.encrypted_password = ""
      user.save(:validate => false)
    end
    @user.oauth_token = auth.credentials.token
    @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    @user.save
    return @user
  end

  def unconfirmed_friend_requests
    return friend_requests.select{|request| friend_ids.exclude?(request.user.id)}
  end

  def self.find_facebook_friends(current_user,friend_uids)
    @result = User.where("uid in (?)", friend_uids)
    if current_user.friend_ids.present?
      @result  = @result.where("id not in (?)",current_user.friend_ids)
    end
    return @result
  end

  def display_name
    if name.present?
      return name
    else
      return email
    end
  end
  def country_name
    if country_code.nil?
      return ""
    end
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

  def avatar_or_default
    if avatar.present?
      return avatar
    else
      return "https://raw.githubusercontent.com/HLVA/eGuru/master/src/app/assets/images/eGuruLogo.png"
    end
  end

  def unfriend(friendship_id)
    @friendship = Friendship.find(friendship_id)
    if @friendship
      @friendship.destroy
      # handle delete 2-way friendship
      @friend_request = friend_requests.find {|request| request.user_id==@friendship.friend_id && request.friend_id==@friendship.user_id}
      if @friend_request
        @friend_request.destroy
      end
    end
  end

  def friend_confirmed (friend_id)
    friends.any? {|friend| friend.id == friend_id} && friend_requests.any? {|request| request.user_id == friend_id}
  end

  def is_facebook_user
    return (provider.present? and provider=="facebook")
  end

  def self.users_are_not_already_friends (current_user, search)

    if current_user.friends.present?
	   @result = User.where("(id not in (?)) and (id != ?)", current_user.friend_ids, current_user.id)
    else
     @result = User.where("(id != ?)", current_user.id)
    end

    if search
      @result = @result.where("email like ?","%#{search}%")
    end
    return @result
  end

end
