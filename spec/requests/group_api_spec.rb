require 'rails_helper'

RSpec.describe "Group", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end

  context "admin" do
    let(:current_user) { create :admin, organization: organization }

    describe "can create groups" do
      it do
        post "/api/v1/groups", params: { group: attributes_for(:group),
                                         authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)

        expect(json_response["group"]["title"]).not_to be_nil
        expect(json_response["group"]["description"]).not_to be_nil
      end
    end

    describe "can edit groups" do
      let(:group) { create :group, organization_id: organization.id }
      let(:new_title) { "Group #5" }

      it do
        put "/api/v1/groups/#{group.id}", params: { group: { title: new_title }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(group.reload.title).to eq(new_title)
      end
    end

    describe "can view groups" do
      let(:group) { create :group, organization_id: organization.id, title: title }
      let(:title) { "Group #5" }
      let!(:group_user) { create :group_user, user: student, group: group }
      let(:student) { create :student, organization: organization }

      it do
        get "/api/v1/groups/#{group.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["group"]["title"]).to eq(title)
      end
    end

    describe "can delete groups" do
      let!(:group) { create :group, organization_id: organization.id }
      it do
        expect do
          delete "/api/v1/groups/#{group.id}", params: { authorization: auth_token_for(current_user) }
        end.to change { Group.count }.from(1).to(0)

        expect(response.status).to eq(200)
      end
    end

    describe "search by term" do
      context "title" do
        let!(:groups) do
          ['Open first', 'Closed second', 'Open third'].each do |title|
            create :group, organization: organization, title: title
          end
        end

        it do
          sleep 1
          get "/api/v1/groups", params: { term: 'open', authorization: auth_token_for(current_user) }
          expect(response.status).to eq(200)
          expect(json_response["groups"].count).to eq(2)
          expect(json_response["groups"][0]["title"]).to eq("Open first")
          expect(json_response["groups"][1]["title"]).to eq("Open third")
        end
      end

      context "description" do
        let!(:groups) do
          ['Open first', 'Closed second', 'Open third'].each do |description|
            create :group, organization: organization, description: description
          end
        end

        it do
          sleep 1
          get "/api/v1/groups", params: { term: 'open', authorization: auth_token_for(current_user) }
          expect(response.status).to eq(200)
          expect(json_response["groups"].count).to eq(2)
          expect(json_response["groups"][0]["description"]).to eq("Open first")
          expect(json_response["groups"][1]["description"]).to eq("Open third")
        end
      end
    end
  end
end