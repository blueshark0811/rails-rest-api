class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :address, :country_id, :created_at, :date_of_birth, :email, :first_name,
  :id, :last_name, :phone_number, :state_id, :status, :updated_at, :zip_code

  belongs_to :country
  belongs_to :state
end
