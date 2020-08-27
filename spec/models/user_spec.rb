require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'some_name')
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_uniqueness_of(:name) }

    it 'is not valid if not unique' do
      User.create(name: 'some_name')
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without the minimum length of name' do
      subject.name = 'd'
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:events_created) }
    it { should have_many(:attended_events).through(:event_attendances) }
    it { should have_many(:event_attendances) }
  end
end
