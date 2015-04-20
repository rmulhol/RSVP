class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]

  def index
    @events = current_user.events
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event successfully created!"
      redirect_to user_events_url(current_user)
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to user_events_url(current_user)
    else
      render "edit"
    end
  end

  private

    def set_event
      @event = current_user.events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :date, :location)
    end
end
