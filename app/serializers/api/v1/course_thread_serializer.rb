class Api::V1::CourseThreadSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :user
end
