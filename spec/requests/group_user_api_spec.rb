require 'rails_helper'

RSpec.describe "Group", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end

  context "admin" do
    let(:current_user) { create :admin, organization: organization }
    let(:student) { create :student, organization: organization }
    let(:group) { create :group, organization: organization }

    describe "can add users to groups" do
      it do
        post "/api/v1/groups/#{group.id}/group_users", params: { group_user: { user_id: student.id }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(student.participated_groups).to include(group)

        # duplication
        post "/api/v1/groups/#{group.id}/group_users", params: { group_user: { user_id: student.id }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(400)
      end
    end
  end
end