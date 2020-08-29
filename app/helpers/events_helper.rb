module EventsHelper
  def event
    @event
  end

  def events
    @events
  end

  def description
    event.description
  end

  def date
    event.date
  end

  def attendees
    event.attendees
  end

  def upcoming_events
    @upcoming_events
  end

  def previous_events
    @previous_events
  end

  def creator
    @creator.name
  end

  def name(attendee)
    attendee.name
  end

  def event_description(event)
    event.description
  end

  def event_date(event)
    event.date
  end

  def set_notice
    flash[:notice] = 'You have already registered for all the available events.'
  end
end
