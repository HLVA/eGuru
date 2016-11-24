class FriendshipsController < ApplicationController
  before_action :require_login
  def index

  end


  def new
    if params[:is_facebook] and params[:is_facebook]==true
      @fb_friends = FbGraph2::User.me(current_user.oauth_token).friends
      @users = User.find_facebook_friends(current_user, @fb_friends.map{|friend|friend.id})
    else
      @users = User.users_are_not_already_friends(current_user,params[:search])
    end
  end

  def create
    @friend = User.find(params[:friend_id])
    if @friend.nil?
      flash[:error] = "Cannot find the user, please check again"
      render 'new'
      return
    end

    @friendship = Friendship.new(user_id:current_user.id, friend_id: @friend.id)
    if @friendship.save
      flash[:success] = "Adding friendship successfully"
      redirect_to new_friendship_path
    else
      flash[:error] = "Cannot add friendships because of the error: " + @friendship.errors.full_messages.to_sentence
    end
  end

  def accept_friend

      @friendship = Friendship.new(user_id:current_user.id, friend_id:params[:friend_id])
      if @friendship.save
        flash[:success] = "You are now friend with " + User.find(params[:friend_id]).display_name
        redirect_to(:back)
      else
        flash[:error] = "Error occurs: " + @friendship.errors.full_messages.to_sentence
        redirect_to(:back)
      end

  end

  def destroy
    current_user.unfriend(params[:id])
    flash[:success] = "You've removed friend successfully"
    redirect_to(:back)
  end
end
