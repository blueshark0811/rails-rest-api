FactoryBot.define do
  factory :course_user do
    user
    course
    course_group nil

    after(:build) do |object|
      unless object.course_group
        group = create :group
        object.course_group = create(:course_group, course: object.course, group: group)
      end
    end
  end
end
