require 'rails_helper'

RSpec.describe EventAttendance, type: :model do
  describe 'Associations' do
    it { should belong_to(:attended_event) }
    it { should belong_to(:event_attendee) }
  end
end
