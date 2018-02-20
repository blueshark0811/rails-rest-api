require 'models_helper'

RSpec.describe Group, type: :model do

  it_behaves_like 'enumerable' do
    let(:fields) { [{ field: :visibility, prefix: true }, :status] }
  end

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
  end
end
