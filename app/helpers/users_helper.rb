module UsersHelper
    def user
        @user
    end

    def upcoming_events
        @upcoming_events
    end

    def prev_events
        @prev_events
    end

    def name(user)
        user.name
    end

    def events_created
        user.events_created
    end

    def attended_events
        user.attended_events
    end

    def event_description(event)
        event.description
    end

    def event_date(event)
        event.date
    end

end