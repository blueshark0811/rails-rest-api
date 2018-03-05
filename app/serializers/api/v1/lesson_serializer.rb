class Api::V1::LessonSerializer < BaseSerializer
  include ApiSerializer

  has_many :actions
  belongs_to :course
end
