require 'rails_helper'

RSpec.describe "Lessons", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end

  context "admin" do
    let(:current_user) { create :admin, organization: organization }
    let(:course) { create :course, organization_id: organization.id, with_organization: false }

    describe "can create lessons" do
      it do
        expect do
          post "/api/v1/courses/#{course.id}/lessons", params: { lesson: attributes_for(:lesson),
                                                                 authorization: auth_token_for(current_user) }
        end.to change { course.reload.lessons.count }.from(0).to(1)
        expect(response.status).to eq(200)

        expect(json_response["lesson"]["title"]).not_to be_nil
        expect(json_response["lesson"]["description"]).not_to be_nil
      end
    end

    describe "can edit lessons" do
      let(:new_description) { "better description" }
      let!(:lesson) { create :lesson, course: course }

      it do
        put "/api/v1/courses/#{course.id}/lessons/#{lesson.id}", params: { lesson: { description: new_description },
                                                                           authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(lesson.reload.description).to eq(new_description)
      end
    end

    describe "can view lessons" do
      let(:title) { "First Lesson" }
      let!(:lesson) { create :lesson, course: course, title: title }

      it do
        get "/api/v1/courses/#{course.id}/lessons/#{lesson.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["lesson"]["title"]).to eq(title)
      end
    end

    describe "can delete lessons" do
      let!(:lesson) { create :lesson, course: course }
      it do
        expect do
          delete "/api/v1/courses/#{course.id}/lessons/#{lesson.id}", params: { authorization: auth_token_for(current_user) }
        end.to change { Lesson.count }.from(1).to(0)

        expect(response.status).to eq(200)
      end
    end
  end
end