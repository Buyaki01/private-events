class User < ApplicationRecord
  has_many :events_created, foreign_key: :creator_id, class_name: 'Event', dependent: :destroy
  has_many :event_attendances, foreign_key: :event_attendee_id, dependent: :destroy
  has_many :attended_events, through: :event_attendances, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  def upcoming_events
    attended_events.find_all do |event|
      event.date >= Date.today
    end
  end

  def previous_events
    attended_events.find_all do |event|
      event.date < Date.today
    end
  end
end
