FactoryBot.define do
  factory :course_group do
    course
    group
    precourse { create :course }
    complete_lesson_can 'all'
    reports_enabled true
    files_enabled true
    discussing_enabled true
    student_content_enabled true
    status 'active'
  end
end
