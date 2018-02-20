require 'models_helper'

RSpec.describe GroupUser, type: :model do
  describe "validate" do
    let(:group_user) { build :group_user }

    it "..and factory should be valid" do
      expect(group_user.valid?).to be_truthy
    end

    it "presence of group_id" do
      group_user.group_id = nil
      group_user.valid?
      expect(group_user.error_keys(:group_id)).to include :blank
    end

    it "presence of user_id" do
      group_user.user_id = nil
      group_user.valid?
      expect(group_user.error_keys(:user_id)).to include :blank
    end

    it "uniqueness of user in group" do
      create :group_user, group: group_user.group, user: group_user.user
      group_user.valid?
      expect(group_user.error_keys(:user_id)).to include :taken
    end

    it "size limitation of group's participants" do
      group_user.group.update_attributes user_limit: 1
      create :group_user, group: group_user.group
      group_user.valid?
      expect(group_user.errors[:group_id]).to include 'size limit of group is reached'
    end
  end
end
