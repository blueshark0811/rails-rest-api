class State < ApplicationRecord
  belongs_to :country
  has_many :users
end
