class User < ApplicationRecord
  include Clearance::User

  mount_uploader :avatar, AvatarUploader
  has_many :conversations, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :friend_requests, class_name:"Friendship", foreign_key: :friend_id

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.email  = auth.uid.to_s + "@dummy.com"
      user.encrypted_password = ""
      user.save(:validate => false)
    end
  end

  def unconfirmed_friend_requests
    return friend_requests.select{|request| friend_ids.exclude?(request.user.id)}
  end

  def display_name
    if provider.present?
      return name
    else
      return email
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
