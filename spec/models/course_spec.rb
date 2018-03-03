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

    context '#course_users' do
      subject { described_class.reflect_on_association(:course_users) }

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

      it 'through association course_users' do
        expect(subject.options[:through]).to eq :course_users
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

    context '#lessons' do
      subject { described_class.reflect_on_association(:lessons) }

      it 'is has many' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'dependent destroy' do
        expect(subject.options[:dependent]).to eq :destroy
      end
    end

    context '#course_groups' do
      subject { described_class.reflect_on_association(:course_groups) }

      it 'is has many' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'dependent destroy' do
        expect(subject.options[:dependent]).to eq :destroy
      end
    end
  end
end
