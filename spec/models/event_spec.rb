require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    let(:creator) do
      User.create(name: 'creator')
    end
    subject do
      described_class.new(description: 'description', date: Date.today, creator_id: creator.id)
    end
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:description) }
    it 'is not valid without the minimum length of description' do
      subject.description = 'de'
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:creator) }
    it { should have_many(:attendees).through(:event_attendances) }
    it { should have_many(:event_attendances) }
  end
end
