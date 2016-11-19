class FriendshipsController < ApplicationController
  before_action :require_login
  def index

  end


  def new
    @users = User.users_are_not_already_friends(current_user,params[:search])
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
      redirect_to friendships_path
    else
      flash[:error] = "Cannot add friendships because of the error: " + @friendship.errors.full_messages.to_sentence
    end
  end

  def destroy
    current_user.unfriend(params[:id])
    flash[:success] = "You've removed friend successfully"
    redirect_to(:back)
  end
end
