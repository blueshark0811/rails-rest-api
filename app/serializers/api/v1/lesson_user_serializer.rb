class Api::V1::LessonUserSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :course_group
end
