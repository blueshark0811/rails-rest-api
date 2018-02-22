require 'models_helper'

RSpec.describe State, type: :model do
  describe 'associations' do
    it 'has many users' do
      expect(described_class.reflect_on_association(:users).macro).to eq(:has_many)
    end

    it 'belongs to country' do
      expect(described_class.reflect_on_association(:country).macro).to eq(:belongs_to)
    end
  end
end
