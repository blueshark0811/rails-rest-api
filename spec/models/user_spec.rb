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

  describe '#set_default_data' do
    let(:status) { nil }
    let(:user) { build :user, status: status }

    it 'should call it on creation' do
      expect(user).to receive(:set_default_data)
      user.save
    end

    it "should set status as 'active'" do
      user = build :user

      expect(user.status).to eq status
      user.save
      expect(user.status).to eq 'active'
    end

    context 'already set data' do
      let!(:status) { 'suspended' }

      it 'should not change status if it is already set some value' do
        expect(user.status).to eq status
        user.save
        expect(user.status).to_not eq 'active'
      end
    end
  end
end
