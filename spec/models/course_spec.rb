require 'models_helper'

RSpec.describe Course, type: :model do

  describe 'associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to organization' do
      expect(described_class.reflect_on_association(:organization).macro).to eq(:belongs_to)
    end

    context '#groups' do
      subject { described_class.reflect_on_association(:groups) }

      it 'has many groups' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association course_groups' do
        expect(subject.options[:through]).to eq :course_groups
      end
    end

    context '#precourses' do
      subject { described_class.reflect_on_association(:precourses) }

      it 'has many precourses' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association course_groups' do
        expect(subject.options[:through]).to eq :course_groups
      end
    end

    it_behaves_like 'attachmentable'

    it 'has many lessons' do
      expect(described_class.reflect_on_association(:lessons).macro).to eq(:has_many)
    end

    it 'has many course_groups' do
      expect(described_class.reflect_on_association(:course_groups).macro).to eq(:has_many)
    end
  end
end
