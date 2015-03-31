class EventsController < ApplicationController
  before_action :logged_in_user

  def index
    @events = current_user.events
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event successfully created!"
      redirect_to events_url
    else
      render "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to events_url
    else
      render "edit"
    end
  end

  private

    def event_params
      params.require(:event).permit(:title, :date, :location)
    end
end
