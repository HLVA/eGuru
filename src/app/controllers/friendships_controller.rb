class FriendshipsController < ApplicationController
  def index

  end

  def new
    @users = User.users_are_not_already_friends(current_user)
  end

  def create
  end

  def destroy
  end
end
