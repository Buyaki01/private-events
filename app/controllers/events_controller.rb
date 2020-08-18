class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:show, :index, :new, :attended_event, :add_attended_event]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @upcoming_events = Event.upcoming_events
    @previous_events = Event.previous_events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @creator = creator
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events_created.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attended_event
    @events = Event.all
  end

  def add_attended_event

    event_ids = params[:event_ids]
    attended_events = event_ids.collect { |id| Event.find(id) }
    @current_user.attended_events = attended_events

    respond_to do |format|
      if @current_user.save
        format.html { redirect_to user_path(@current_user), notice: 'Attended events were successfully added.' }
        format.json { render user_path, status: 'events added', location: @current_user }
      else
        format.html { render attended_events_path }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_current_user
      redirect_to sign_in_path unless current_user
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
