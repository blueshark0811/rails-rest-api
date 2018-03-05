class Video < ApplicationRecord
  VIDEOABLES = %w[Action Organization]
  belongs_to :organization
  belongs_to :user
  belongs_to :videoable, polymorphic: true, optional: true
end
