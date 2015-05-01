class AccountActivationsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: :edit
  skip_before_action :redirect_if_incorrect_user, only: :edit

  def new
  end

  def create
    if current_user.update(email: params[:account_activation][:email])
      current_user.create_activation_digest
      UserMailer.account_activation(current_user).deliver_now
      flash[:info] = "Please check your email to activate your account"
      redirect_to current_user
    else
      flash[:danger] = "Please enter a valid email address"
      render "new"
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
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