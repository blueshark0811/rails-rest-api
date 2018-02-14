require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "validate" do
    let(:group) { build :group }

    it "..and factory should be valid" do
      expect(group.valid?).to be_truthy
    end

    it "presence of organization_id" do
      group.organization_id = nil
      group.valid?
      expect(group.errors[:organization_id]).to_not be_blank
    end

    it "presence of status" do
      group.status = nil
      group.valid?
      expect(group.errors[:status]).to_not be_blank
    end

    it "presence of visibility" do
      group.visibility = nil
      group.valid?
      expect(group.errors[:visibility]).to_not be_blank
    end
  end
end
