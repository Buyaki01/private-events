class Event < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :event_attendances, foreign_key: :attended_event_id
    has_many :attendees, through: :event_attendances, source: :event_attendee
    validates :description, presence: true, length: { minimum: 3 }, uniqueness: true
    validates :date, presence: true

    scope :upcoming_events, -> {
        Event.all.find_all do |event|
            event.date >= Date.today
        end 
    }

    scope :previous_events, -> {
        Event.all.find_all do |event|
            event.date < Date.today
        end
    }
end
