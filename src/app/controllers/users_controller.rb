class UsersController < Clearance::UsersController
	before_action :set_user, only: [:show, :edit, :update, :destroy, :profile]
	skip_before_action :require_login, only: [:new, :create]
	def new
	  @user=User.new
	  uploader = AvatarUploader.new
	end

	def create
    @user = User.new user_params

    if @user.save
      sign_in @user
			flash[:sucess] = "User has been signed up successfully"
      redirect_to root_path
    else
			flash[:error] = "Error when save user: " + @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

	def show
	end

	def profile
	end

	def update
		if @user.update(user_params)
			flash[:success] = "User has been updated successfully"
			redirect_to user_profile_path(:id=>@user.id)
		else
			flash[:error] = "Update failed because of the following errors: " + @user.errors.full_messages.to_sentence
			render 'edit'
		end
	end


private
def set_user
	@user = User.find(params[:id])
end
def user_params
    params.require(:user).permit(:email, :name, :password, :birthday, :country_code, :avatar,:sender_id,:recipient_id)
  end

	def user_from_params
		user_params = params[:user] || Hash.new
    name = user_params.delete(:name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.email = email
      user.password = password
    end
	end


end
