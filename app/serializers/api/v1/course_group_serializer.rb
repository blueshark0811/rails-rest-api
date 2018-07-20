class Api::V1::CourseGroupSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :course
end
