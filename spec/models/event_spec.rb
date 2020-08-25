require 'rails_helper'

RSpec.describe Event, type: :model do
  #  describe 'validation' do
  #    it { should ensure_length_of(:description).is_at_least(3) }
  #    it { should validate_presence_of(:description) }
  #    it { should validate_uniqueness_of(:description) }

  #   it { should validate_presence_of(:date) }
  #  end

  describe 'Associations' do
    it { should belong_to(:creator) }
    it { should have_many(:attendees).through(:event_attendances) }
    it { should have_many(:event_attendances) }
  end
end
