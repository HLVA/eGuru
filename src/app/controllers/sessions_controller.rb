class SessionsController < Clearance::SessionsController
  def create
    if env["omniauth.auth"].present?
      @user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = @user.id
      flash[:success] = "loggin successfully"
      sign_in(@user)
      redirect_to root_url
    end
  end
end
