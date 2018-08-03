require 'rails_helper'

RSpec.describe "Courses", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end

  context "admin" do
    let(:current_user) { create :admin, organization: organization }

    describe "can create courses" do
      it do
        post "/api/v1/courses", params: { course: attributes_for(:course),
                                          authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)

        expect(json_response["course"]["title"]).not_to be_nil
        expect(json_response["course"]["description"]).not_to be_nil
        expect(json_response["course"]["image"]["url"]).not_to be_nil
        expect(json_response["course"]["banner_image"]["url"]).not_to be_nil
      end
    end

    describe "can edit courses" do
      let(:course) { create :course, organization_id: organization.id, with_organization: false }
      let(:new_title) { "Algebra #5" }

      it do
        put "/api/v1/courses/#{course.id}", params: { course: { title: new_title }, authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(course.reload.title).to eq(new_title)
      end
    end

    describe "can view courses" do
      let(:course) { create :course, organization_id: organization.id, with_organization: false, title: new_title }
      let(:new_title) { "Algebra #5" }

      it do
        get "/api/v1/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["title"]).to eq(new_title)
      end
    end

    describe "can delete courses" do
      let!(:course) { create :course, organization_id: organization.id, with_organization: false }
      it do
        expect do
          delete "/api/v1/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        end.to change { Course.count }.from(1).to(0)

        expect(response.status).to eq(200)
      end
    end
  end

  context "teacher" do
    let(:current_user) { create :teacher, organization: organization }
    let!(:group) { create :group, organization: organization }

    describe "can view courses" do
      let!(:course_group) { create :course_group, course: course, group: group, precourse: nil }
      let!(:course) { create :course, organization_id: organization.id, with_organization: false, title: new_title }
      let!(:group_user) { create :group_user, user: current_user, group: group }
      let(:new_title) { "Algebra #5" }

      it do
        get "/api/v1/groups/#{group.id}/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["title"]).to eq(new_title)
      end
    end
  end

  context "student" do
    let(:current_user) { create :student, organization: organization }
    let!(:group) { create :group, organization: organization }

    describe "can view courses" do
      let!(:course_group) { create :course_group, course: course, group: group, precourse: nil }
      let!(:course) { create :course, organization_id: organization.id, with_organization: false, title: new_title }
      let!(:group_user) { create :group_user, user: current_user, group: group }
      let(:new_title) { "Algebra #5" }

      it do
        get "/api/v1/groups/#{group.id}/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["title"]).to eq(new_title)
      end
    end
  end
end