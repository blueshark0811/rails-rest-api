class Api::V1::CourseSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :user
  belongs_to :organization
end
