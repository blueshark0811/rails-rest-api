class Addon < ApplicationRecord
  has_many :addon_courses, dependent: :destroy
  has_many :courses, through: :addon_courses

  has_many :addon_organizations, dependent: :destroy
  has_many :organizations, through: :addon_organizations

  validates :title, presence: true
end
