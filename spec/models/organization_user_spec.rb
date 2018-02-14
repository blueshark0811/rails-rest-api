require "rails_helper"

RSpec.describe OrganizationUser, type: :model do
  describe "validate" do
    let(:organization_user) { build :organization_user }
    
    it "..and factory shorganization_userld be valid" do
      expect(organization_user.valid?).to be_truthy
    end

    it "presence of user_id" do
      organization_user.user_id = nil
      organization_user.valid?
      expect(organization_user.errors[:user_id]).to_not be_blank
    end

    it "presence of organization_id" do
      organization_user.organization_id = nil
      organization_user.valid?
      expect(organization_user.errors[:organization_id]).to_not be_blank
    end

    it "presence of role" do
      organization_user.role = nil
      organization_user.valid?
      expect(organization_user.errors[:role]).to_not be_blank
    end
  end
end
