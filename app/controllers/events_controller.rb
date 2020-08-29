class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_current_user, only: %i[show index new attend_events show_events]

  # GET /events
  def index
    @events = Event.all
    @upcoming_events = Event.upcoming
    @previous_events = Event.previous
  end

  # GET /events/1
  def show
    @creator = creator
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events

  def create
    @event = current_user.events_created.build(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      flash[:errors] = @event.errors.full_messages
      render :new
    end
  end

  def show_events
    @events = Event.all.reject { |event| @current_user.attended_events.include?(event) || event.date < Time.zone.today }
  end

  def attend_events
    event_ids = params[:event_ids]
    attended_events = event_ids.collect { |id| Event.find(id) }
    @current_user.attended_events << attended_events

    if @current_user.save
      redirect_to user_path(@current_user), notice: 'You have successfully registered for the chosen event(s)'
    else
      render attended_events_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.fetch(:event, {}).permit(:date, :description)
  end

  def creator
    @creator = User.find_by(id: @event.creator_id)
  end
end
