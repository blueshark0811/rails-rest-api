require 'models_helper'

describe Task, type: :model do
  let(:task) { create :task }

  it_behaves_like 'enumerable' do
    let(:fields) { %i[task_type] }
  end

  describe 'associations' do
    it 'belongs to lesson' do
      expect(described_class.reflect_on_association(:lesson).macro).to eq(:belongs_to)
    end

    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    context '#course' do
      subject { described_class.reflect_on_association(:course) }

      it 'has one course' do
        expect(subject.macro).to eq(:has_one)
      end

      it 'through :lesson association' do
        expect(subject.options[:through]).to eq(:lesson)
      end
    end

    it_behaves_like 'attachmentable'
    it_behaves_like 'videoable'
  end
end
