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

  describe '#role' do
    let(:role) { OrganizationUser.roles.keys.first }
    let(:role2) { OrganizationUser.roles.keys.last }

    let(:organization) { create :organization }
    let(:user) { create :user, role: role, organization: organization }
    let(:organization2) { create :organization }
    let!(:organization_user2) { create :organization_user, user: user, organization: organization2, role: role2 }

    it 'returns role' do
      expect(user.role(organization)).to eq role
    end

    it 'returns role depend from sent organization' do
      expect(user.role(organization2)).to eq role2
    end

    it 'cache role for specific organization' do
      allow(user).to receive(:organization_users).and_return OrganizationUser
      expect(user).to receive(:organization_users).once
      user.role organization
      user.role organization
    end
  end

  describe '#organization_status' do
    let(:status) { OrganizationUser.statuses.keys.first }
    let(:status2) { OrganizationUser.statuses.keys.last }

    let(:organization) { create :organization }
    let(:user) { create :user, status: status, organization: organization }
    let(:organization2) { create :organization }
    let!(:organization_user2) { create :organization_user, user: user, organization: organization2, status: status2 }

    it 'returns status' do
      expect(user.organization_status(organization)).to eq status
    end

    it 'returns sttus depend from sent organization' do
      expect(user.organization_status(organization2)).to eq status2
    end

    it 'cache status for specific organization' do
      allow(user).to receive(:organization_users).and_return OrganizationUser
      expect(user).to receive(:organization_users).once
      user.organization_status organization
      user.organization_status organization
    end
  end

  describe '#jwt_token' do
    subject { user.jwt_token }

    context 'user is not confirmed' do
      let(:user) { create :user, confirmed_at: nil }

      it { is_expected.to be_nil }
    end

    context 'user confirmed' do
      let(:user) { create :user, remember_created_at: nil }

      it { is_expected.to be_kind_of(String) }

      it 'update remember_created_at' do
        expect(user.remember_created_at).to be_nil
        subject
        expect(user.remember_created_at).to_not be_nil
      end

      it 'encode token via jwt lib' do
        expect(JWT).to receive(:encode).with(
          {
            id: user.id,
            exp: user.remember_expires_at.to_i,
            type: user.class.name.to_s.downcase,
            email: user.email
          },
          APP_CONFIG['api']['jwt']['secret'], APP_CONFIG['api']['jwt']['algorithm']
        )
        subject
      end
    end
  end

  describe '#current_organization' do
    subject { described_class.new }
    it { is_expected.to respond_to(:current_organization) }
    it { is_expected.to respond_to('current_organization=') }
  end

  describe '#current_organization_user' do
    let(:organization) { create :organization }
    before { user.organizations << organization }

    context 'when organization sent as parameter' do
      subject { user.current_organization_user organization }

      it 'returns organization_user instance for current user and organization' do
        expect(subject.organization_id).to eq organization.id
        expect(subject.user_id).to eq user.id
      end
    end

    context 'when organization as attr accessor in instance' do
      subject { user.current_organization_user }

      it 'returns organization_user instance for current user and organization' do
        user.current_organization = organization
        expect(subject.organization_id).to eq organization.id
        expect(subject.user_id).to eq user.id
      end
    end

    context 'when organization as attr accessor did not set and did not send as parameter ' do
      subject { user.current_organization_user }

      it { is_expected.to be_nil }
    end
  end

  describe '.find_by_token' do
    let(:token) { user.jwt_token }
    subject { User.find_by_token token }

    context 'when token blank' do
      let(:token) { nil }
      it { is_expected.to be_nil }
    end

    context 'when token is valid' do
      it { is_expected.to be_kind_of User }

      context 'but expired' do
        it 'returns nil' do
          allow_any_instance_of(User).to receive(:remember_expired?).and_return true
          is_expected.to be_nil
        end
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid_token' }
      it { is_expected.to be_nil }
    end
  end

  describe '#set_temp_passsword' do
    let(:user) { build :user, password: password }

    context 'when password is not set' do
      let(:password) { nil }

      context 'when user creating' do
        it 'generates password before validation' do
          user.valid?
          expect(user.password).to_not be_nil
        end

        it 'makes validation passed' do
          expect(user.valid?).to be_truthy
        end
      end

      xcontext 'when user updating' do
      end
    end

    context 'when password is set' do
      let(:password) { 'password' }

      context 'when user creating' do
        it 'does not change password' do
          user.valid?
          expect(user.password).to eq password
        end
      end

      xcontext 'when user updating' do
      end
    end
  end

  describe '#search_data' do
    subject { user.search_data }

    it 'returns all base attributes' do
      expect((subject.keys.map(&:to_sym)&User.attributes).size).to eq User.attributes.size
    end

    it 'returns aditionaly group_ids' do
      expect(subject.key?(:group_ids)).to be_truthy
    end

    it 'returns aditionaly organization_ids' do
      expect(subject.key?(:organization_ids)).to be_truthy
    end
  end
end
