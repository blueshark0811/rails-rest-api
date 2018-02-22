require 'models_helper'

describe CourseGroup, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { [{ field: :complete_lesson_can, prefix: true }, :status] }
  end

  describe 'associations' do
    it 'belongs to course' do
      expect(described_class.reflect_on_association(:course).macro).to eq(:belongs_to)
    end

    it 'belongs to group' do
      expect(described_class.reflect_on_association(:group).macro).to eq(:belongs_to)
    end

    context '#precourse' do
      subject { described_class.reflect_on_association(:precourse) }

      it 'belongs to precourse' do
        expect(subject.macro).to eq(:belongs_to)
      end

      it 'is for model Course' do
        expect(subject.options[:class_name]).to eq 'Course'
      end
    end
  end
end
