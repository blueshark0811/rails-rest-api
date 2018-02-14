require "rails_helper"

describe User, type: :model do
  let(:user) { create :user }

  describe "association" do
    describe "#country" do
      let(:country) { create :country }
      let(:user) { create :user, country: country }

      it "should return Country instance" do
        expect(user.country).to be country
      end

      context "if empty" do
        let(:country) { nil }

        it "no problem for creating user" do
          expect(user.country).to be nil
          expect(user.new_record?).to be_falsy
        end
      end
    end

    describe "#state" do
      let(:state) { create :state }
      let(:user) { create :user, state: state }

      it "should return State instance" do
        expect(user.state).to be state
      end

      context "if empty" do
        let(:state) { nil }

        it "no problem for creating user" do
          expect(user.state).to be nil
          expect(user.new_record?).to be_falsy
        end
      end
    end
  end

  describe "#remember_expired?" do
    it "should return boolean value" do
      expect([true, false]).to include(user.remember_expired?)
    end
  end

  describe "#set_default_data" do
    let(:status) { nil }
    let(:user) { build :user, status: status }

    it "should call it on creation" do
      expect(user).to receive(:set_default_data)
      user.save
    end

    it "should set status as 'active'" do
      user = build :user

      expect(user.status).to eq status
      user.save
      expect(user.status).to eq "active"
    end

    context 'already set data' do
      let!(:status) { 'suspended' }

      it "should not change status if it is already set some value" do
        expect(user.status).to eq status
        user.save
        expect(user.status).to_not eq "active"
      end
    end
  end
end
