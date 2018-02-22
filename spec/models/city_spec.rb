require 'models_helper'

RSpec.describe City, type: :model do
  describe 'associations' do
    it "belongs to state" do
      expect(described_class.reflect_on_association(:state).macro).to eq(:belongs_to)
    end
  end
end
