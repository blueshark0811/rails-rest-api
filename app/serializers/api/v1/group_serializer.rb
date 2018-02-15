class Api::V1::GroupSerializer < ActiveModel::Serializer
  attributes :created_at, :description, :id, :organization_id,
  :status, :title, :updated_at, :user_limit, :visibility

  belongs_to :organization
end
