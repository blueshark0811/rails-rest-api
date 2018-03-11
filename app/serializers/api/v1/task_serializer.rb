class Api::V1::TaskSerializer < BaseSerializer
  include ApiSerializer

  belongs_to :lesson
  belongs_to :user
  has_one :course
  has_many :attachments
  has_many :videos
end
