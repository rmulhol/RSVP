class EventsController < ApplicationController
  def index
    @events = current_user.events
  end

  def show
    @event = current_user.events.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @user = current_user
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event successfully created!"
      redirect_to user_events_url(current_user)
    else
      render "new"
    end
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to user_events_url(current_user)
    else
      render "edit"
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :date, :location)
    end
end
