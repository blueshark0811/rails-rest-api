require 'models_helper'

RSpec.describe Group, type: :model do
  it_behaves_like 'enumerable' do
    let(:fields) { [{ field: :visibility, prefix: true }, :status] }
  end

  describe 'validate' do
    let(:group) { build :group }

    it '..and factory should be valid' do
      expect(group.valid?).to be_truthy
    end

    it 'presence of organization_id' do
      group.organization_id = nil
      group.valid?
      expect(group.errors[:organization_id]).to_not be_blank
    end
  end

  describe 'scopes' do
    describe '.participated_by' do
      let(:user) { create :user }
      let(:groups) { create_list :group, 2 }
      let!(:group_user) { create :group_user, group: groups.first, user: user }
      subject { described_class.participated_by(user).to_a }

      it 'returns groups where user participated' do
        is_expected.to include groups.first
      end

      it 'not returns groups where user is not participated' do
        is_expected.to_not include groups.last
      end
    end
  end

  describe 'associations' do
    it 'belongs to organization' do
      expect(described_class.reflect_on_association(:organization).macro).to eq(:belongs_to)
    end

    context '#group_users' do
      subject { described_class.reflect_on_association(:group_users) }

      it 'is has many association' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'dependent destroy' do
        expect(subject.options[:dependent]).to eq :destroy
      end
    end

    context '#users' do
      subject { described_class.reflect_on_association(:users) }

      it 'has many users' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association group_users' do
        expect(subject.options[:through]).to eq :group_users
      end
    end

    context '#course_groups' do
      subject { described_class.reflect_on_association(:course_groups) }

      it 'is has many association' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'dependent destroy' do
        expect(subject.options[:dependent]).to eq :destroy
      end
    end

    context '#courses' do
      subject { described_class.reflect_on_association(:courses) }

      it 'has many courses' do
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

    context '#lessons' do
      subject { described_class.reflect_on_association(:lessons) }

      it 'has many lessons' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association courses' do
        expect(subject.options[:through]).to eq :courses
      end
    end

    it_behaves_like 'attachmentable'
  end
end
