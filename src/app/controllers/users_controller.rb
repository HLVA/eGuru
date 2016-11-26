class UsersController < Clearance::UsersController

	def new
	  @user=User.new
	  uploader = AvatarUploader.new
	end

	def create
    @user = User.new user_params

    if @user.save
      sign_in @user
      redirect_to root_path
    else
			flash[:error] = "Error when save user: " + @user.errors.full_messages.to_sentence
      render 'new'
    end
  end

	def show
		@user = User.find(params[:id])
	end

	def profile
		@user = User.find(params[:id])
	end


private
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
