require 'rails_helper'

RSpec.describe "Group", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end

  context "admin" do
    let(:current_user) { create :admin, organization: organization }

    describe "can add users to groups" do
      let(:student) { create :student, organization: organization }
      let(:group) { create :group, organization: organization }

      it do
        post "/api/v1/groups/#{group.id}/group_users", params: { group_user: { user_id: student.id }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(student.participated_groups).to include(group)

        # duplication
        post "/api/v1/groups/#{group.id}/group_users", params: { group_user: { user_id: student.id }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(400)
      end
    end

    describe do
      let!(:student) { create :student, organization: organization }
      let(:group1) { create :group, organization: organization }
      let(:group2) { create :group, organization: organization }

      it do
        post "/api/v1/groups/#{group1.id}/group_users", params: { group_user: { user_id: student.id }, authorization: auth_token_for(current_user) }
        sleep 2
        expect(response.status).to eq(200)
        expect(student.participated_groups).to include(group1)
        expect(student.participated_groups).not_to include(group2)

        get "/api/v1/groups/#{group1.id}/group_users", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["group_users"].size).to eq(1)

        get "/api/v1/groups/#{group2.id}/group_users", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["group_users"].size).to eq(0)
      end
    end
  end
end