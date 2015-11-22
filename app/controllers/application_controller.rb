class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    User.new(session[:id])
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end

  helper_method :current_user
end
