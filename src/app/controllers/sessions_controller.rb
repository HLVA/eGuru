class SessionsController < Clearance::SessionsController
  def create
    if env["omniauth.auth"].present?
      @user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = @user.id
      flash[:success] = "loggin successfully"
      # auth.cookies.signed["current_user_id"] = user.id
      sign_in(@user)
      redirect_to after_login_path
    end
  end
end
