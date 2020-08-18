class Event < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :event_attendances, foreign_key: :attended_event_id
    has_many :attendees, through: :event_attendances, source: :event_attendee

    def self.upcoming_events
        Event.all.find_all do |event|
            event.date >= Date.today
        end 
    end

    def self.previous_events
        Event.all.find_all do |event|
            event.date < Date.today
        end
    end
end
