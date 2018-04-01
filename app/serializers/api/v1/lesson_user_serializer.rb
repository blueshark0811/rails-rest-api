class Api::V1::LessonUserSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :lesson
  belongs_to :user
end
