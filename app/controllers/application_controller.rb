class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_incorrect_user

  def redirect_if_not_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def redirect_if_incorrect_user
    user = params[:user_id] ? User.find_by(id: params[:user_id]) : User.find_by(id: params[:id])
    unless current_user?(user)
      redirect_to root_url
    end
  end
end
