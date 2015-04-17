class GuestsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  before_action :set_event, only: [:create, :update, :edit, :destroy]
  before_action :redirect_if_incorrect_user, only: [:edit, :update, :destroy]

  def new
    @event = Event.find(params[:event_id])
    @guest = @event.guests.build
  end

  def create
    @guest = @event.guests.build(guest_params)
    if @guest.save
      flash[:success] = "Thanks for adding your info!"
      if logged_in?
        redirect_to user_event_path(user_id: @event.user_id, id: @event)
      else
        redirect_to root_url
      end
    else
      render "new"
    end
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update_attributes(guest_params)
      flash[:success] = "Guest successfully updated"
      redirect_to user_event_path(user_id: params[:user_id], id: params[:event_id])
    else
      render "edit"
    end
  end

  def destroy
    Guest.find(params[:id]).destroy
    flash[:success] = "Guest successfully removed"
    redirect_to user_event_path(user_id: @event.user_id, id: @event)
  end

  private

    def guest_params
      params.require(:guest).permit(:name, :responsibility, :event_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
