require 'models_helper'

describe Lesson, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { %i[status] }
  end

  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to course' do
      expect(described_class.reflect_on_association(:course).macro).to eq(:belongs_to)
    end

    context '#lesson_users' do
      subject { described_class.reflect_on_association(:lesson_users) }

      it 'is has many' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'dependent destroy' do
        expect(subject.options[:dependent]).to eq :destroy
      end
    end

    context '#users' do
      subject { described_class.reflect_on_association(:users) }

      it 'is has many' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association lesson_users' do
        expect(subject.options[:through]).to eq :lesson_users
      end
    end

    it_behaves_like 'attachmentable'
  end
end
