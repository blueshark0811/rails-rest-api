require 'models_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it "has many users" do
      expect(described_class.reflect_on_association(:users).macro).to eq(:has_many)
    end

    it "has many states" do
      expect(described_class.reflect_on_association(:states).macro).to eq(:has_many)
    end
  end
end
