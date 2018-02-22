require 'models_helper'

RSpec.describe Video, type: :model do

  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to organization' do
      expect(described_class.reflect_on_association(:organization).macro).to eq(:belongs_to)
    end

    context '#videoable' do
      subject { described_class.reflect_on_association(:videoable) }

      it 'belongs to videoable' do
        expect(subject.macro).to eq(:belongs_to)
      end

      it 'is polymorphic' do
        expect(subject.options[:polymorphic]).to be_truthy
      end

      it 'is optional' do
        expect(subject.options[:optional]).to be_truthy
      end
    end
  end
end
