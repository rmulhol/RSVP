class UsersController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  skip_before_action :redirect_if_incorrect_user, only: [:new, :create]
  before_action :set_user, only: [:dashboard, :show, :edit, :change_password, :update]

  def dashboard
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the RSVP App!"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
  end

  def change_password
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def identify_user_in_params
      User.find_by(id: params[:id])
    end
end
