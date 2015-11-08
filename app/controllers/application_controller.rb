class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.new(session[:user_email], session[:user_name], session[:user_image]) if session[:user_email]
  end
  helper_method :current_user

end

class User < Struct.new(:email, :name, :image)
end
