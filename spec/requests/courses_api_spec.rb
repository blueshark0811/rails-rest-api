require 'rails_helper'

RSpec.shared_examples "user has correct authorization" do
  it do
    sleep 1 # because of CourseUserJob performed async
    get "/api/v1/groups/#{groups[1].id}/courses", params: { authorization: auth_token_for(current_user) }
    expect(response.status).to eq(200)
    expect(json_response["courses"].count).to eq(1)
    expect(json_response["courses"][0]['title']).to eq("Basic Algebra")
  end
end

RSpec.shared_examples "finds History" do
  it do
    sleep 1 # because of CourseUserJob performed async
    get "/api/v1/groups/#{groups[2].id}/courses", params: { term: 'greek', authorization: auth_token_for(current_user) }
    expect(response.status).to eq(200)
    expect(json_response["courses"].count).to eq(1)
    expect(json_response["courses"][0]['title']).to eq("Basic History")
  end
end

RSpec.shared_examples "should not find History" do
  it do
    sleep 1 # because of CourseUserJob performed async
    get "/api/v1/groups/#{groups[2].id}/courses", params: { term: 'basic', authorization: auth_token_for(current_user) }
    expect(response.status).to eq(200)
    expect(json_response["courses"].count).to eq(2)
    expect(json_response["courses"][0]['title']).to eq("Basic Algebra")
    expect(json_response["courses"][1]['title']).to eq("Basic Chemistry")
  end
end

RSpec.describe "Courses", type: :request do
  let(:organization) { create :organization }

  before do
    host! "#{organization.subdomain}.example.com"
  end


  context "index" do
    # it should work for student and teacher if they have access to the groups or courses
    # for ex. if admin has created 5 groups:
    #
    # Group 1 - course 1, course 2, course 3
    # Group 2 - course 1,
    # Group 3 - course 1, course 2
    # Group 4 - course 3
    # Group 5 - course 2
    #
    # student 1 is assigned group 2
    #
    # so even if student searches for course 2, it should not work
    #
    # as student has no access to it

    let!(:algebra_course) {
      create :course, organization_id: organization.id, with_organization: false, title: "Basic Algebra", description: <<STR
Algebra (from Arabic "al-jabr", literally meaning "reunion of broken parts"[1]) is one of the broad parts of mathematics, together with number theory, geometry and analysis.
STR
    }

    let!(:chemistry_course) {
      create :course, organization_id: organization.id, with_organization: false, title: "Basic Chemistry", description: <<STR
Chemistry is the scientific discipline involved with compounds composed of atoms, i.e. elements, and molecules, i.e. combinations of atoms: their composition, structure, properties, behavior and the changes they undergo during a reaction with other compounds.
STR
    }

    let!(:history_course) {
      create :course, organization_id: organization.id, with_organization: false, title: "Basic History", description: <<STR
History (from Greek ἱστορία, historia, meaning "inquiry, knowledge acquired by investigation")[2] is the study of the past as it is described in written documents.[3][4] Events occurring before written record are considered prehistory.
STR
    }

    let!(:groups) do
      create_list :group, 5, organization: organization
    end

    before do
      create :course_group, course: algebra_course, group: groups[0], precourse: nil
      create :course_group, course: chemistry_course, group: groups[0], precourse: nil
      create :course_group, course: history_course, group: groups[0], precourse: nil

      create :course_group, course: algebra_course, group: groups[1], precourse: nil

      create :course_group, course: algebra_course, group: groups[2], precourse: nil
      create :course_group, course: chemistry_course, group: groups[2], precourse: nil

      create :course_group, course: history_course, group: groups[3], precourse: nil
      create :course_group, course: chemistry_course, group: groups[4], precourse: nil
    end

    context do
      before do
        create :group_user, user: current_user, group: groups[1]
      end

      context "student" do
        let(:current_user) { create :student, organization: organization }

        it_behaves_like "user has correct authorization"
      end

      context "teacher" do
        let(:current_user) { create :teacher, organization: organization }

        it_behaves_like "user has correct authorization"
      end
    end

    context "searching by term" do
      before do
        create :group_user, user: current_user, group: groups[2]
      end

      context "student" do
        let(:current_user) { create :student, organization: organization }

        it_behaves_like "should not find History"
      end

      context "teacher" do
        let(:current_user) { create :teacher, organization: organization }

        it_behaves_like "should not find History"
      end
    end
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
      let(:course) { create :course, organization_id: organization.id, with_organization: false, title: title }
      let(:title) { "Algebra #5" }

      it do
        get "/api/v1/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["title"]).to eq(title)
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
    let!(:course_group) { create :course_group, course: course, group: group, precourse: nil }
    let!(:group_user) { create :group_user, user: current_user, group: group }

    describe "can view courses" do
      let!(:course) { create :course, organization_id: organization.id, with_organization: false, title: new_title }
      let(:new_title) { "Algebra #5" }

      it do
        get "/api/v1/groups/#{group.id}/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["title"]).to eq(new_title)
      end
    end


    describe "with lessons" do
      let(:lessons) { create_list :lesson, 5, course: course }
      let(:course) { create :course, organization_id: organization.id, with_organization: false }

      before do
        create(:lesson_user, :completed, user: current_user, lesson: lessons[0])
        create(:lesson_user, user: current_user, lesson: lessons[1])
        create(:lesson_user, :completed, user: current_user, lesson: lessons[2])
      end

      it do
        get "/api/v1/groups/#{group.id}/courses/#{course.id}", params: { authorization: auth_token_for(current_user) }
        expect(response.status).to eq(200)
        expect(json_response["course"]["completed_lessons"]).to eq(2)
        expect(json_response["course"]["incompleted_lessons"]).to eq(3)
        expect(json_response["course"]["lessons_count"]).to eq(5)
      end
    end
  end
end