class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  skip_before_action :redirect_if_incorrect_user

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def identify_user_in_params
      if !params[:user_id].blank?
        User.find_by(id: params[:user_id])
      elsif !params[:event_id].blank?
        Event.find_by(id: params[:event_id]).user
      else
        User.find_by(id: params[:id])
      end
    end
end
