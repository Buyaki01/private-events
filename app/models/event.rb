class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendances, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :event_attendances, source: :event_attendee, dependent: :destroy
  validates :description, presence: true, length: { minimum: 3 }, uniqueness: true

  validates :date, presence: true, inclusion: { in: (Time.zone.today..Time.zone.today + 5.years) }

  scope :upcoming, -> { where('date >= ?', Time.zone.now) }

  scope :previous, -> { where('date < ?', Time.zone.now) }
end
