class UsersController < Clearance::UsersController

	def new
	  @user=User.new
	  uploader = AvatarUploader.new
	end

	def show
		@user = User.find(params[:id])
	end


private
def user_params
    params.require(:user).permit(:email, :avatar,:sender_id,:recipient_id)
  end


end
