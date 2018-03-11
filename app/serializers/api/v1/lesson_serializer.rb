class Api::V1::LessonSerializer < BaseSerializer
  include ApiSerializer

  has_many :tasks
  belongs_to :course
end
