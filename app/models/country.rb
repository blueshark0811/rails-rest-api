class Country < ApplicationRecord
  searchkick callbacks: :async, word_start: [:name], searchable: %i[name]

  has_many :states
  has_many :users
  has_many :organizations
end
