class GuestsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  before_action :redirect_if_incorrect_user, only: [:edit, :update, :destroy]
  before_action :set_user_event_and_guest, only: [:new, :create, :edit, :update, :destroy]

  def new
    @guest = @event.guests.build
  end

  def create
    @guest = @event.guests.build(guest_params)
    if @guest.save
      flash[:success] = "Thanks for adding your info!"
      if user_owns_event?        
        redirect_to user_event_path(user_id: @user, id: @event) 
      else
        redirect_to root_url
      end
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @guest.update_attributes(guest_params)
      flash[:success] = "Guest successfully updated"
      redirect_to user_event_path(user_id: params[:user_id], id: params[:event_id])
    else
      render "edit"
    end
  end

  def destroy
    @guest.destroy
    flash[:success] = "Guest successfully removed"
    redirect_to user_event_path(user_id: @user, id: @event)
  end

  private

    def guest_params
      params.require(:guest).permit(:name, :responsibility, :event_id)
    end

    def set_user_event_and_guest
      @user = User.find_by(id: params[:user_id])
      @event = @user.events.find_by(id: params[:event_id])
      @guest = @user.guests.find_by(id: params[:id])
    end

    def user_owns_event?
      logged_in? && @event.user_id == current_user.id
    end
end
