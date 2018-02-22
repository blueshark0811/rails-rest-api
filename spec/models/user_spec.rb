# frozen_string_literal: true

require 'models_helper'

describe User, type: :model do
  let(:user) { create :user }

  it_behaves_like 'enumerable' do
    let(:fields) { %i[admin_role status] }
  end

  describe 'association' do
    describe '#country' do
      let(:country) { create :country }
      let(:user) { create :user, country: country }

      it 'should return Country instance' do
        expect(user.country).to be country
      end

      context 'if empty' do
        let(:country) { nil }

        it 'no problem for creating user' do
          expect(user.country).to be nil
          expect(user.new_record?).to be_falsy
        end
      end
    end

    describe '#state' do
      let(:state) { create :state }
      let(:user) { create :user, state: state }

      it 'should return State instance' do
        expect(user.state).to be state
      end

      context 'if empty' do
        let(:state) { nil }

        it 'no problem for creating user' do
          expect(user.state).to be nil
          expect(user.new_record?).to be_falsy
        end
      end
    end

    it 'has many organization_users' do
      expect(described_class.reflect_on_association(:organization_users).macro).to eq(:has_many)
    end

    it 'has many group_users' do
      expect(described_class.reflect_on_association(:group_users).macro).to eq(:has_many)
    end

    it 'has many actions' do
      expect(described_class.reflect_on_association(:actions).macro).to eq(:has_many)
    end

    it 'has many attachments' do
      expect(described_class.reflect_on_association(:attachments).macro).to eq(:has_many)
    end

    it 'has many courses' do
      expect(described_class.reflect_on_association(:courses).macro).to eq(:has_many)
    end

    it 'has many groups' do
      expect(described_class.reflect_on_association(:groups).macro).to eq(:has_many)
    end

    it 'has many files' do
      expect(described_class.reflect_on_association(:files).macro).to eq(:has_many)
    end

    it 'has many lessons' do
      expect(described_class.reflect_on_association(:lessons).macro).to eq(:has_many)
    end

    it 'has many videos' do
      expect(described_class.reflect_on_association(:videos).macro).to eq(:has_many)
    end

    context '#organizations' do
      subject { described_class.reflect_on_association(:organizations) }

      it 'has many organizations' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association organization_users' do
        expect(subject.options[:through]).to eq :organization_users
      end
    end

    context '#participated_groups' do
      subject { described_class.reflect_on_association(:participated_groups) }

      it 'has many participated_groups' do
        expect(subject.macro).to eq(:has_many)
      end

      it 'through association group_users' do
        expect(subject.options[:through]).to eq :group_users
      end

      it 'for class Group' do
        expect(subject.options[:class_name]).to eq 'Group'
      end
    end
  end

  describe '#remember_expire_at' do
    subject { user.remember_expire_at }

    context 'when user never signed in or signed out' do
      it { is_expected.to be_nil }
    end

    context 'when user signed in before' do
      subject { user.remember_expire_at.utc.to_s }
      let(:remember_created_at) { Time.zone.now }
      let(:user) { create :user, remember_created_at: remember_created_at }

      it "return datetime of sign in + #{User.remember_for} as in config" do
        is_expected.to eq((remember_created_at+User.remember_for).utc.to_s)
      end
    end
  end

  describe '#remember_expired?' do
    subject { user.remember_expired? }

    it { is_expected.to be_in([true, false]) }

    context 'when user never signed in or signed out' do
      it { is_expected.to be_truthy }
    end

    context 'when user has not expired token' do
      let(:user) { create :user, remember_created_at: Time.zone.now }
      it { is_expected.to be_falsey }
    end

    context 'when user has expired token' do
      let(:user) { create :user, remember_created_at: (1.day.ago-User.remember_for) }
      it { is_expected.to be_truthy }
    end
  end
end
