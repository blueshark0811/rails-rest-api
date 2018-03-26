class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state
end
