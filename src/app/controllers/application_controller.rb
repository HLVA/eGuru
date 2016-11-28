class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login
  protect_from_forgery with: :exception

  def clear_message
    flash[:error] = ""
    flash[:success] = ""
  end
end
